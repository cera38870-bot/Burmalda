<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BURMALDA NEWS — СЕКРЕТНОЕ ДОСЬЕ</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Courier New', monospace;
            background: #0a0a0a;
            color: #e0e0e0;
            line-height: 1.6;
            background-image: 
                repeating-linear-gradient(
                    0deg,
                    transparent,
                    transparent 2px,
                    rgba(0, 255, 0, 0.03) 2px,
                    rgba(0, 255, 0, 0.03) 4px
                );
        }
        
        .container {
            max-width: 900px;
            margin: 0 auto;
            padding: 20px;
        }
        
        /* Header */
        .header {
            background: linear-gradient(135deg, #1a1a1a 0%, #0d0d0d 100%);
            border: 2px solid #333;
            padding: 30px;
            margin-bottom: 30px;
            position: relative;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.8);
        }
        
        .confidential-stamp {
            position: absolute;
            top: 20px;
            right: 30px;
            border: 3px solid #ff0000;
            color: #ff0000;
            padding: 10px 15px;
            font-weight: bold;
            font-size: 0.9em;
            transform: rotate(15deg);
            opacity: 0.8;
            text-transform: uppercase;
            letter-spacing: 2px;
        }
        
        .logo {
            font-size: 2.5em;
            font-weight: bold;
            color: #fff;
            text-transform: uppercase;
            letter-spacing: 3px;
            margin-bottom: 5px;
        }
        
        .subtitle {
            color: #666;
            font-size: 0.9em;
            letter-spacing: 2px;
        }
        
        /* Main Dossier */
        .dossier {
            background: #111;
            border: 1px solid #333;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.9);
        }
        
        .dossier-title {
            color: #ff3333;
            font-size: 1.8em;
            text-transform: uppercase;
            letter-spacing: 3px;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #ff3333;
        }
        
        .profile-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin: 20px 0;
            background: #0d0d0d;
            padding: 20px;
            border: 1px solid #222;
        }
        
        .profile-field {
            border-bottom: 1px solid #333;
            padding-bottom: 8px;
        }
        
        .field-label {
            color: #888;
            font-size: 0.85em;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 5px;
        }
        
        .field-value {
            color: #fff;
            font-size: 1.1em;
            font-weight: bold;
        }
        
        .status-field {
            color: #ff3333;
        }
        
        /* Sections */
        .section {
            margin: 30px 0;
            padding: 20px;
            background: #0d0d0d;
            border-left: 3px solid #ff3333;
        }
        
        .section-title {
            color: #ff3333;
            font-size: 1.3em;
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }
        
        .section-title::before {
            content: "⚠️";
            margin-right: 10px;
        }
        
        .features-list {
            list-style: none;
            padding-left: 0;
        }
        
        .features-list li {
            padding: 8px 0;
            padding-left: 25px;
            position: relative;
            color: #ccc;
        }
        
        .features-list li::before {
            content: "•";
            color: #ff3333;
            font-weight: bold;
            position: absolute;
            left: 10px;
        }
        
        /* Warning Box */
        .warning-box {
            background: linear-gradient(135deg, #1a0000 0%, #0d0000 100%);
            border: 2px solid #ff0000;
            padding: 20px;
            text-align: center;
            margin-top: 30px;
        }
        
        .warning-text {
            color: #ff3333;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 2px;
            font-size: 1.1em;
        }
        
        /* Victim Section */
        .victim-section {
            background: #0a0a0a;
            border: 1px solid #440000;
            padding: 25px;
            margin: 30px 0;
        }
        
        .victim-title {
            color: #ff0000;
            font-size: 1.5em;
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        /* Footer */
        .footer {
            background: #0d0d0d;
            border-top: 2px solid #333;
            padding: 20px;
            text-align: center;
            color: #555;
            font-size: 0.85em;
            margin-top: 30px;
        }
        
        .breaking-news {
            background: #ff0000;
            color: #000;
            padding: 10px;
            text-align: center;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-bottom: 20px;
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.7; }
        }
        
        .extra-info {
            background: #1a1a00;
            border-left: 3px solid #ffff00;
            padding: 15px;
            margin: 20px 0;
        }
        
        .extra-info strong {
            color: #ffff00;
        }
        
        a {
            color: #4ecdc4;
            text-decoration: none;
        }
        
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="breaking-news">🚨 СРОЧНЫЕ НОВОСТИ 🚨</div>
        
        <div class="header">
            <div class="confidential-stamp">TOP SECRET<br>CONFIDENTIAL</div>
            <div class="logo">BURMALDA NEWS</div>
            <div class="subtitle">НЕЗАВИСИМОЕ АГЕНТСТВО СТРАННЫХ НОВОСТЕЙ</div>
        </div>
        
        <div class="dossier">
            <h1 class="dossier-title">SHIZUKEZA</h1>
            
            <div class="profile-grid">
                <div class="profile-field">
                    <div class="field-label">НИК</div>
                    <div class="field-value">shizukeza</div>
                </div>
                <div class="profile-field">
                    <div class="field-label">ВОЗРАСТ</div>
                    <div class="field-value">18 лет</div>
                </div>
                <div class="profile-field">
                    <div class="field-label">ДОЛЖНОСТЬ</div>
                    <div class="field-value">Администратор чата</div>
                </div>
                <div class="profile-field">
                    <div class="field-label">TELEGRAM</div>
                    <div class="field-value">@seventy38k</div>
                </div>
                <div class="profile-field">
                    <div class="field-label">СТАТУС</div>
                    <div class="field-value status-field">🐿️ БЕШЕНАЯ БЕЛКА</div>
                </div>
            </div>
            
            <div class="extra-info">
                <strong>ТАКЖЕ ИЗВЕСТЕН КАК:</strong> Соса / Sosa<br>
                <strong>ПРЕДАТЕЛЬСТВО:</strong> Променял @Escanor_the_one1 (Матерый Булыжник) на Roblox
            </div>
            
            <div class="section">
                <div class="section-title">ОСОБЫЕ ПРИМЕТЫ</div>
                <ul class="features-list">
                    <li>🐿️ Злобный карлик</li>
                    <li> Любит грызть какашки</li>
                    <li>⚔️ Имеет особую слабость к Сой Фон</li>
                    <li>🔞 Испытывает к Сой Фон весьма специфические чувства</li>
                    <li>🐿️ Может внезапно впасть в режим бешеной белки</li>
                    <li>😡 Отличается крайне злобным характером</li>
                    <li>🧠 Имеет подозрительно странные увлечения</li>
                    <li>⚠️ Может быть бешеным</li>
                    <li>❗ При упоминании Сой Фон уровень опасности резко повышается</li>
                    <li>🔒 Не рекомендуется оставлять без присмотра в интернете</li>
                </ul>
            </div>
            
            <div class="section" style="border-left-color: #4ecdc4;">
                <div class="section-title" style="color: #4ecdc4;">📡 МЕСТО ОБИТАНИЯ</div>
                <p style="color: #ccc;">Администраторский чат <strong>BLEACH Soul Resonance RU</strong></p>
            </div>
            
            <div class="warning-box">
                <div class="warning-text">⚠️ ПРИ ВСТРЕЧЕ РЕКОМЕНДУЕТСЯ СОБЛЮДАТЬ ОСТОРОЖНОСТЬ ️</div>
            </div>
        </div>
        
        <div class="victim-section">
            <h2 class="victim-title">⚰️ ОДНА ИЗ ЖЕРТВ</h2>
            
            <div class="profile-grid" style="background: #1a0000;">
                <div class="profile-field">
                    <div class="field-label">НИК</div>
                    <div class="field-value">@Escanor_the_one1</div>
                </div>
                <div class="profile-field">
                    <div class="field-label">ПРОЗВИЩЕ</div>
                    <div class="field-value">Матерый Булыжник</div>
                </div>
                <div class="profile-field">
                    <div class="field-label">ВОЗРАСТ</div>
                    <div class="field-value">27 лет</div>
                </div>
                <div class="profile-field">
                    <div class="field-label">СТАТУС</div>
                    <div class="field-value status-field">🔨 БУЛЫЖНИК</div>
                </div>
            </div>
            
            <div class="section">
                <div class="section-title">ПРИМЕТЫ</div>
                <ul class="features-list">
                    <li>😊 Дружелюбный</li>
                    <li>👷 Работяга</li>
                    <li>🐱 Любит кошкодевочек</li>
                    <li>️ Ставит на аватарки непристойные фото с героями аниме Блич</li>
                </ul>
            </div>
            
            <div class="warning-box">
                <div class="warning-text">💀 ПАЛ ЖЕРТВОЙ ОТ РУК SHIZUKEZA</div>
                <p style="color: #888; margin-top: 10px; font-size: 0.9em;">(после того как был променян на Roblox)</p>
            </div>
        </div>
        
        <div class="dossier" style="border: 1px solid #8b4513;">
            <h1 class="dossier-title" style="color: #ffd700; border-bottom-color: #ffd700;">🐹 XOMYAKADZE</h1>
            
            <div class="profile-grid" style="background: #1a0f00;">
                <div class="profile-field">
                    <div class="field-label">НИК</div>
                    <div class="field-value">xomyakadze</div>
                </div>
                <div class="profile-field">
                    <div class="field-label">TELEGRAM</div>
                    <div class="field-value">@xomyakadze</div>
                </div>
                <div class="profile-field">
                    <div class="field-label">ПРОЗВИЩЕ</div>
                    <div class="field-value">🐹 Гомяк</div>
                </div>
                <div class="profile-field">
                    <div class="field-label">СТАТУС</div>
                    <div class="field-value" style="color: #ffd700;">👑 Владелец чата</div>
                </div>
            </div>
            
            <div class="section" style="border-left-color: #ffd700;">
                <div class="section-title" style="color: #ffd700;"> ОСОБЕННОСТИ</div>
                <ul class="features-list">
                    <li>🌰 Любит грызть орехи</li>
                    <li>🤚 Любит мацать шизукезу</li>
                    <li>😌 Спокойный</li>
                    <li>😴 Любит спать</li>
                    <li>😡 Иногда агрессивный</li>
                </ul>
            </div>
            
            <div class="extra-info" style="background: #1a0f00; border-left-color: #ffd700;">
                <strong>📡 ССЫЛКА НА ЧАТ:</strong><br>
                <a href="https://t.me/BLEACHSoulResonanceRUChat" style="color: #4ecdc4;">https://t.me/BLEACHSoulResonanceRUChat</a>
            </div>
        </div>
        
        <div class="footer">
            <p>⚠️ ДАННЫЙ ЭКЗЕМПЛЯР МОЖЕТ БЫТЬ НЕПРЕДСКАЗУЕМЫМ. ВСЕ СОВПАДЕНИЯ С РЕАЛЬНЫМИ СОБЫТИЯМИ СЛУЧАЙНЫ.</p>
            <p style="margin-top: 10px;">© 2026 BURMALDA NEWS — СЕКРЕТНОЕ ДОСЬЕ</p>
        </div>
    </div>
</body>
</html>