import sqlite3
import random
import string
from datetime import datetime
from aiogram import Bot, Dispatcher, F
from aiogram.filters import Command, CommandStart
from aiogram.types import (
    Message, InlineQuery, InlineQueryResultArticle,
    InputTextMessageContent, ReplyKeyboardMarkup, KeyboardButton,
    InlineKeyboardMarkup, InlineKeyboardButton
)
from aiogram.enums import ParseMode

# ==================== НАСТРОЙКИ ====================
BOT_TOKEN = "8659397108:AAHQ_f01RM7RSOUgdNlVnWMZ2AKSaVy8OxI"
ADMIN_ID = 5296078628
PRANK_TEXT = "Попался, паршивый дрочун! Больше так не делай!"

# ==================== БАЗА ДАННЫХ ====================
def init_db():
    conn = sqlite3.connect("trap_bot.db")
    c = conn.cursor()
    c.execute("""CREATE TABLE IF NOT EXISTS links (
        id TEXT PRIMARY KEY,
        text TEXT,
        creator_id INTEGER,
        creator_name TEXT,
        created_at TEXT
    )""")
    c.execute("""CREATE TABLE IF NOT EXISTS clicks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        link_id TEXT,
        user_id INTEGER,
        username TEXT,
        clicked_at TEXT
    )""")
    c.execute("""CREATE TABLE IF NOT EXISTS admin_media (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        file_id TEXT,
        file_type TEXT,
        added_at TEXT
    )""")
    conn.commit()
    conn.close()

def save_link(link_id, text, creator_id, creator_name):
    conn = sqlite3.connect("trap_bot.db")
    c = conn.cursor()
    c.execute("INSERT INTO links VALUES (?, ?, ?, ?, ?)",
              (link_id, text, creator_id, creator_name, datetime.now().isoformat()))
    conn.commit()
    conn.close()

def save_click(link_id, user_id, username):
    conn = sqlite3.connect("trap_bot.db")
    c = conn.cursor()
    c.execute("INSERT INTO clicks (link_id, user_id, username, clicked_at) VALUES (?, ?, ?, ?)",
              (link_id, user_id, username or "нет", datetime.now().isoformat()))
    conn.commit()
    conn.close()

def get_link(link_id):
    conn = sqlite3.connect("trap_bot.db")
    c = conn.cursor()
    c.execute("SELECT * FROM links WHERE id = ?", (link_id,))
    row = c.fetchone()
    conn.close()
    return row

def get_stats():
    conn = sqlite3.connect("trap_bot.db")
    c = conn.cursor()
    c.execute("""SELECT l.id, l.text, l.creator_name, l.created_at,
                 COUNT(cl.id) as clicks FROM links l
                 LEFT JOIN clicks cl ON l.id = cl.link_id
                 GROUP BY l.id ORDER BY clicks DESC""")
    rows = c.fetchall()
    conn.close()
    return rows

def get_link_details(link_id):
    conn = sqlite3.connect("trap_bot.db")
    c = conn.cursor()
    c.execute("SELECT * FROM links WHERE id = ?", (link_id,))
    link = c.fetchone()
    c.execute("SELECT user_id, username, clicked_at FROM clicks WHERE link_id = ? ORDER BY clicked_at DESC", (link_id,))
    clicks = c.fetchall()
    conn.close()
    return link, clicks

def add_admin_media(file_id, file_type):
    conn = sqlite3.connect("trap_bot.db")
    c = conn.cursor()
    c.execute("INSERT INTO admin_media (file_id, file_type, added_at) VALUES (?, ?, ?)",
              (file_id, file_type, datetime.now().isoformat()))
    conn.commit()
    conn.close()

def get_random_media():
    conn = sqlite3.connect("trap_bot.db")
    c = conn.cursor()
    c.execute("SELECT file_id, file_type FROM admin_media ORDER BY RANDOM() LIMIT 1")
    row = c.fetchone()
    conn.close()
    return row

def get_media_count():
    conn = sqlite3.connect("trap_bot.db")
    c = conn.cursor()
    c.execute("SELECT COUNT(*) FROM admin_media")
    count = c.fetchone()[0]
    conn.close()
    return count

# ==================== БОТ ====================
bot = Bot(token=BOT_TOKEN)
dp = Dispatcher()
init_db()

def main_keyboard():
    return ReplyKeyboardMarkup(keyboard=[
        [KeyboardButton(text="📊 Статистика"), KeyboardButton(text="🔗 Создать ссылку")],
        [KeyboardButton(text="ℹ️ Помощь")]
    ], resize_keyboard=True)

# Inline-режим: когда пишут @Sisipopakakachh_bot текст в любом чате
@dp.inline_query()
async def inline_handler(query: InlineQuery):
    text = query.query.strip()
    
    if not text:
        results = [
            InlineQueryResultArticle(
                id="help",
                title="Как создать ловушку?",
                description="Напиши @Sisipopakakachh_bot и текст ссылки",
                input_message_content=InputTextMessageContent(
                    "✍️ Напиши: @Sisipopakakachh_bot сочные булочки\n"
                    "Бот создаст ссылку-ловушку!"
                )
            )
        ]
    else:
        # Генерируем ссылку
        unique_id = ''.join(random.choices(string.ascii_lowercase + string.digits, k=8))
        link_id = f"{text.lower().replace(' ', '_')}_{unique_id}"
        
        bot_info = await bot.get_me()
        trap_link = f"https://t.me/{bot_info.username}?start={link_id}"
        
        # Сохраняем ссылку
        save_link(
            link_id=link_id,
            text=text,
            creator_id=query.from_user.id,
            creator_name=query.from_user.full_name
        )
        
        results = [
            InlineQueryResultArticle(
                id=link_id,
                title=f"🎣 Ловушка: {text}",
                description="Нажми чтобы вставить ссылку в чат",
                input_message_content=InputTextMessageContent(
                    f"🔗 {trap_link}"
                )
            )
        ]
    
    await query.answer(results, cache_time=0)

# /start с параметром (переход по ловушке)
@dp.message(CommandStart(deep_link=True))
async def handle_trap_link(message: Message):
    deep_link = message.text.split()[1] if len(message.text.split()) > 1 else None
    if not deep_link:
        return
    
    link_data = get_link(deep_link)
    if not link_data:
        await message.answer("🤷 Ссылка не найдена или устарела.")
        return
    
    link_id, text, creator_id, creator_name, created_at = link_data
    
    # Сохраняем клик
    username = message.from_user.username
    save_click(link_id, message.from_user.id, username)
    
    # Отправляем рандомный стикер или GIF
    media = get_random_media()
    
    if media:
        file_id, file_type = media
        try:
            if file_type == "sticker":
                await bot.send_sticker(message.chat.id, sticker=file_id)
            elif file_type == "animation":
                await bot.send_animation(message.chat.id, animation=file_id)
        except Exception as e:
            print(f"Ошибка отправки медиа: {e}")
    else:
        await message.answer("🎭 Админ ещё не загрузил стикеры!")
    
    # Текст под стикером
    await message.answer(f"<b>{PRANK_TEXT}</b>\n\n<i>Ты перешёл по ссылке: {text}</i>", parse_mode=ParseMode.HTML)

# Обычный /start
@dp.message(CommandStart())
async def cmd_start(message: Message):
    if message.from_user.id == ADMIN_ID:
        await message.answer(
            f"👑 <b>Привет, Админ!</b>\n\n"
            f"📊 Стикеров/GIF в базе: {get_media_count()}\n\n"
            "Отправь мне стикер или GIF — я добавлю его в ловушки.\n"
            "Используй кнопки ниже 👇",
            reply_markup=main_keyboard(),
            parse_mode=ParseMode.HTML
        )
    else:
        await message.answer("👋 Привет! Я бот для пранков.")

# Кнопка "Создать ссылку" (для админа в ЛС)
@dp.message(F.text == "🔗 Создать ссылку")
async def create_link_cmd(message: Message):
    if message.from_user.id != ADMIN_ID:
        return
    await message.answer("✍️ Напиши фразу для ссылки", reply_markup=ReplyKeyboardMarkup(
        keyboard=[[KeyboardButton(text="📊 Статистика"), KeyboardButton(text="ℹ️ Помощь")]],
        resize_keyboard=True
    ))

# Обработка текста от админа (создание ссылки в ЛС)
@dp.message(F.text & ~F.text.startswith("/"))
async def create_link(message: Message):
    if message.from_user.id != ADMIN_ID:
        return
    
    text = message.text.strip()
    if len(text) < 3:
        await message.answer("❌ Фраза слишком короткая.")
        return
    
    unique_id = ''.join(random.choices(string.ascii_lowercase + string.digits, k=8))
    link_id = f"{text.lower().replace(' ', '_')}_{unique_id}"
    
    save_link(
        link_id=link_id,
        text=text,
        creator_id=message.from_user.id,
        creator_name=message.from_user.full_name
    )
    
    bot_info = await bot.get_me()
    trap_link = f"https://t.me/{bot_info.username}?start={link_id}"
    
    await message.answer(
        f"✅ <b>Ловушка создана!</b>\n\n"
        f"📝 Фраза: <i>{text}</i>\n"
        f"🔗 Ссылка:\n{trap_link}\n\n"
        f"Отправь её жертве! 😈",
        reply_markup=main_keyboard(),
        parse_mode=ParseMode.HTML
    )

# Кнопка "Статистика" (только админ)
@dp.message(F.text == "📊 Статистика")
async def show_stats(message: Message):
    if message.from_user.id != ADMIN_ID:
        await message.answer("🔒 Только для админа!")
        return
    
    stats = get_stats()
    if not stats:
        await message.answer(" Пока нет ловушек.")
        return
    
    text = "📊 <b>Статистика ловушек:</b>\n\n"
    keyboard = []
    
    for link_id, link_text, creator, created, clicks in stats:
        text += f"🔗 <b>{link_text}</b>\n"
        text += f"   👤 Создатель: {creator}\n"
        text += f"   🎯 Переходов: <b>{clicks}</b>\n\n"
        keyboard.append([InlineKeyboardButton(
            text=f"📋 {link_text[:20]} ({clicks})",
            callback_data=f"detail_{link_id}"
        )])
    
    await message.answer(
        text,
        reply_markup=InlineKeyboardMarkup(inline_keyboard=keyboard),
        parse_mode=ParseMode.HTML
    )

# Детали по ссылке
@dp.callback_query(F.data.startswith("detail_"))
async def link_details(callback):
    if callback.from_user.id != ADMIN_ID:
        await callback.answer("🔒 Доступ запрещён", show_alert=True)
        return
    
    link_id = callback.data.replace("detail_", "")
    link, clicks = get_link_details(link_id)
    
    if not link:
        await callback.answer("Ссылка не найдена", show_alert=True)
        return
    
    link_id, text, creator_id, creator_name, created_at = link
    
    details = f"📋 <b>Детали ловушки:</b>\n\n"
    details += f"📝 Фраза: <i>{text}</i>\n"
    details += f"👤 Создатель: {creator_name}\n"
    details += f"🕐 Создана: {created_at[:19].replace('T', ' ')}\n"
    details += f"🎯 Всего переходов: <b>{len(clicks)}</b>\n\n"
    details += f"<b>Кто переходил:</b>\n"
    
    if clicks:
        for i, (user_id, username, clicked_at) in enumerate(clicks[:20], 1):
            details += f"{i}. @{username or user_id} — {clicked_at[:19].replace('T', ' ')}\n"
        if len(clicks) > 20:
            details += f"\n...и ещё {len(clicks) - 20} человек"
    else:
        details += "Пока никто не попался 😅"
    
    await callback.message.edit_text(details, parse_mode=ParseMode.HTML)
    await callback.answer()

# Кнопка "Помощь"
@dp.message(F.text == "ℹ️ Помощь")
async def help_cmd(message: Message):
    if message.from_user.id != ADMIN_ID:
        return
    await message.answer(
        "<b>Как пользоваться:</b>\n\n"
        "1️⃣ <b>В любом чате:</b> напиши @Sisipopakakachh_bot и текст\n"
        "   Пример: @Sisipopakakachh_bot сочные булочки\n"
        "   Бот создаст ссылку — нажми на неё чтобы вставить в чат\n\n"
        "2️⃣ <b>В ЛС бота:</b> нажми  Создать ссылку и напиши текст\n\n"
        "3️⃣ <b>Загрузка стикеров/GIF:</b> просто отправь мне стикер или GIF в ЛС\n\n"
        "4️ <b>Статистика:</b> нажми 📊 чтобы увидеть кто попался",
        parse_mode=ParseMode.HTML
    )

# Загрузка стикеров и GIF от админа
@dp.message(F.sticker)
async def handle_sticker(message: Message):
    if message.from_user.id != ADMIN_ID:
        return
    file_id = message.sticker.file_id
    add_admin_media(file_id, "sticker")
    count = get_media_count()
    await message.answer(f"✅ Стик добавлен! Всего в базе: {count}", reply_markup=main_keyboard())

@dp.message(F.animation)
async def handle_gif(message: Message):
    if message.from_user.id != ADMIN_ID:
        return
    file_id = message.animation.file_id
    add_admin_media(file_id, "animation")
    count = get_media_count()
    await message.answer(f"✅ GIF добавлен! Всего в базе: {count}", reply_markup=main_keyboard())

# ==================== ЗАПУСК ====================
if __name__ == "__main__":
    import asyncio
    asyncio.run(dp.start_polling(bot))
