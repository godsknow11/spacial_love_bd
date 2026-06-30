# Minimalist Polaroid Storybook Birthday SPA Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Rebuild index.html to be a beautiful, minimalist Polaroid Storybook SPA for a 26th birthday celebration.

**Architecture:** A single-page application with a cover envelope transition, an interactive centered Polaroid photo deck showing 4 chapters of the couple's journey, and a interactive candle-blowing confetti finale.

**Tech Stack:** Vanilla HTML, CSS, JavaScript (zero external JS dependencies, Google Fonts for typography).

## Global Constraints
- Primary Typography: Noto Sans Thai and Sarabun from Google Fonts.
- Accents Typography: Playfair Display from Google Fonts.
- Responsive design targeting both mobile viewport and desktop viewport.
- Avoid external libraries; use native browser APIs (Web Audio API, Canvas, IntersectionObserver).

---

### Task 1: Scaffolding, Global Layout, and Envelope Cover

**Files:**
- Modify: `index.html`

**Interfaces:**
- Produces: CSS variables and cover screen layout for the intro.

- [ ] **Step 1: Write structure, typography imports, and variables**
Modify the top of `index.html` to import fonts and define minimal rose-gold and cream colors.

```html
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Happy 26th Birthday, My Love ❤️</title>
    
    <!-- Modern Typography: Sarabun & Playfair Display -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Sarabun:wght@300;400;500;600;700&family=Playfair+Display:ital,wght@0,400;0,600;0,700;1,400&display=swap" rel="stylesheet">

    <style>
        :root {
            --bg-cream: #fcfaf6;
            --text-charcoal: #2a2927;
            --text-muted: #7a7772;
            --rose-gold: #d4b2a7;
            --rose-gold-glow: rgba(212, 178, 167, 0.4);
            --card-bg: #ffffff;
            --border-light: rgba(42, 41, 39, 0.08);
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Sarabun', sans-serif;
            background-color: var(--bg-cream);
            color: var(--text-charcoal);
            overflow: hidden;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* --- COVER SCREEN (ENVELOPE INTRO) --- */
        #cover-screen {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            background-color: var(--bg-cream);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 999;
            transition: opacity 0.8s ease, transform 0.8s ease;
        }

        .envelope-card {
            background: var(--card-bg);
            border: 1px solid var(--border-light);
            border-radius: 16px;
            padding: 50px 30px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.04);
            max-width: 400px;
            width: 90%;
            cursor: pointer;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .envelope-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(212, 178, 167, 0.2);
        }

        .envelope-icon {
            font-size: 3.5rem;
            margin-bottom: 20px;
            display: inline-block;
            animation: heartFloat 3s ease-in-out infinite;
        }

        @keyframes heartFloat {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-8px); }
        }

        .envelope-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.8rem;
            font-style: italic;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .envelope-subtitle {
            color: var(--text-muted);
            font-size: 0.95rem;
            font-weight: 300;
            margin-bottom: 30px;
        }

        .envelope-btn {
            background: var(--text-charcoal);
            color: var(--bg-cream);
            border: none;
            padding: 12px 30px;
            border-radius: 25px;
            font-size: 0.95rem;
            font-weight: 500;
            cursor: pointer;
            transition: opacity 0.2s;
            font-family: 'Sarabun', sans-serif;
        }

        .envelope-btn:hover {
            opacity: 0.9;
        }
    </style>
</head>
<body>
    <div id="cover-screen" onclick="startExperience()">
        <div class="envelope-card">
            <div class="envelope-icon">💌</div>
            <h2 class="envelope-title">ถึง... คนพิเศษของใจ</h2>
            <p class="envelope-subtitle">คุณได้รับจดหมายวันเกิดฉบับพิเศษ</p>
            <button class="envelope-btn">เปิดอ่านการ์ด ✨</button>
        </div>
    </div>
    
    <script>
        function startExperience() {
            const cover = document.getElementById('cover-screen');
            cover.style.opacity = '0';
            cover.style.transform = 'scale(0.95)';
            setTimeout(() => {
                cover.style.display = 'none';
            }, 800);
        }
    </script>
</body>
</html>
```

- [ ] **Step 2: Commit**

```bash
git add index.html
git commit -m "feat: implement minimalist layout and envelope intro cover"
```

---

### Task 2: The Polaroid Deck Layout & Navigation

**Files:**
- Modify: `index.html`

**Interfaces:**
- Consumes: Cover Screen.
- Produces: Chapter story deck, navigation controls, and slides structure.

- [ ] **Step 1: Write Polaroid card HTML & CSS styles**
Add the layout for the centered Polaroid card, placeholders for photos, and navigation elements.

```html
    <!-- Insert inside <body>, right after #cover-screen -->
    <div class="stage-container">
        <div class="polaroid-card">
            <!-- Polaroid Photo Frame -->
            <div class="polaroid-photo-frame">
                <div class="photo-placeholder">
                    <span class="photo-placeholder-icon">📸</span>
                    <span class="photo-placeholder-text">[ วางรูปภาพคู่ของเราตรงนี้ ]</span>
                </div>
                <img id="polaroid-img" class="polaroid-img" src="" alt="Our Memory" style="display: none;">
            </div>
            
            <!-- Date & Title Meta -->
            <div class="polaroid-meta">
                <span id="chapter-title" class="chapter-title">Chapter 01</span>
                <span id="chapter-date" class="chapter-date">Our Journey</span>
            </div>

            <!-- Story Text Caption -->
            <p id="polaroid-caption" class="polaroid-caption"></p>
        </div>

        <!-- Left/Right Nav Arrows -->
        <button id="prev-btn" class="nav-arrow" onclick="prevSlide()" title="ย้อนกลับ">←</button>
        <button id="next-btn" class="nav-arrow" onclick="nextSlide()" title="ถัดไป">→</button>

        <!-- Progress Dots Indicator -->
        <div id="progress-dots" class="progress-dots"></div>
    </div>
```

Modify the CSS block inside `<style>` to add:
```css
        .stage-container {
            max-width: 500px;
            width: 90%;
            position: relative;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .polaroid-card {
            background: var(--card-bg);
            border: 1px solid var(--border-light);
            padding: 24px;
            padding-bottom: 40px;
            box-shadow: 0 15px 45px rgba(0, 0, 0, 0.03);
            border-radius: 12px;
            width: 100%;
            display: flex;
            flex-direction: column;
            transform: rotate(-1deg);
            transition: transform 0.6s cubic-bezier(0.175, 0.885, 0.32, 1.275), opacity 0.5s ease;
        }

        .polaroid-photo-frame {
            background: #faf9f6;
            border: 1px dashed var(--rose-gold);
            aspect-ratio: 1 / 1;
            width: 100%;
            border-radius: 6px;
            overflow: hidden;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            margin-bottom: 30px;
        }

        .photo-placeholder {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 10px;
            color: var(--text-muted);
            font-size: 0.9rem;
        }

        .photo-placeholder-icon {
            font-size: 2rem;
            opacity: 0.6;
        }

        .polaroid-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .polaroid-meta {
            font-family: 'Playfair Display', serif;
            font-style: italic;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid var(--border-light);
            padding-bottom: 10px;
            margin-bottom: 15px;
        }

        .chapter-title {
            font-size: 1.15rem;
            color: var(--text-charcoal);
            font-weight: 600;
        }

        .chapter-date {
            font-size: 0.95rem;
            color: var(--text-muted);
        }

        .polaroid-caption {
            font-size: 1rem;
            line-height: 1.8;
            color: var(--text-charcoal);
            min-height: 120px;
            white-space: pre-line;
        }

        /* --- NAVIGATION ARROWS --- */
        .nav-arrow {
            position: absolute;
            top: 45%;
            transform: translateY(-50%);
            background: none;
            border: none;
            font-size: 1.8rem;
            color: var(--text-charcoal);
            cursor: pointer;
            padding: 10px;
            transition: transform 0.2s, opacity 0.2s;
            opacity: 0.6;
            z-index: 10;
        }

        .nav-arrow:hover {
            opacity: 1;
            transform: translateY(-50%) scale(1.15);
        }

        #prev-btn {
            left: -60px;
        }

        #next-btn {
            right: -60px;
        }

        @media (max-width: 600px) {
            #prev-btn { left: -15px; background: rgba(255,255,255,0.8); border-radius: 50%; width: 40px; height: 40px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
            #next-btn { right: -15px; background: rgba(255,255,255,0.8); border-radius: 50%; width: 40px; height: 40px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        }

        /* --- PROGRESS DOTS --- */
        .progress-dots {
            display: flex;
            gap: 8px;
            margin-top: 30px;
        }

        .dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background-color: var(--border-light);
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .dot.active {
            background-color: var(--rose-gold);
            box-shadow: 0 0 8px var(--rose-gold);
        }
```

- [ ] **Step 2: Add interactive JavaScript deck engine**
Implement chapter data arrays and page state logic inside the script tag.

```javascript
        // Insert inside <script>
        const storyChapters = [
            {
                chapter: "Chapter 01",
                date: "Our Journey",
                text: "ปีนี้เป็นปีที่เราสองคนผ่านเรื่องราวอะไรด้วยกันมาเยอะมากจริงๆ มีทั้งรอยยิ้มและเรื่องราวต่างๆ แต่สุดท้ายเราก็ผ่านมาด้วยกันได้",
                image: "assets/stormy_umbrella.png"
            },
            {
                chapter: "Chapter 02",
                date: "Health & Care",
                text: "ปีนี้เห็นเธอป่วยบ่อย เค้าเป็นห่วงมากๆ เลยนะ ไม่อยากเห็นเธอป่วยเลย อยากให้เธอแข็งแรงและอยู่กับเค้าไปนานๆ ไม่ว่าวันข้างหน้าจะเป็นยังไง ขอให้รู้ไว้ว่าเค้าจะคอยอยู่ข้างๆ เธอเสมอ",
                image: "assets/cozy_together.png"
            },
            {
                chapter: "Chapter 03",
                date: "Our Promise",
                text: "และปีนี้... คำสัญญาของเราเป็นจริงแล้วนะ ที่เค้าได้ไปหมั้นเธอ ดีใจหรือเปล่า? เป้าหมายต่อไปของเราคือ 'งานแต่งงาน' (แล้วก็พากันกินให้อ้วน 555 แหย่เล่นน้า) เค้าคิดถึงเป้าหมายนี้ทุกวันเลย อยากแต่งงานกับเธอเร็วๆ จัง สงสัยต้องรีบลุยหาเงินมาแต่งซะแล้วสิ",
                image: "assets/starry_future.png"
            },
            {
                chapter: "Chapter 04",
                date: "Together Forever",
                text: "เนื่องในวันเกิดอายุครบ 26 ปีบริบูรณ์ของเธอ เค้าขอให้ที่รักสุขภาพร่างกายแข็งแรง ไม่เจ็บไม่ป่วย หันมาดูแลตัวเองและออกกำลังกายเยอะๆ นะ ถ้ามีเรื่องอะไรไม่สบายใจ หันมาบอกเค้าได้ทุกเรื่องเลย เค้าพร้อมจะอยู่ตรงนี้ เป็นที่พักพิงให้เธอได้บ่นตลอดไปเลยนะ เรามาพยายามสร้างครอบครัวและอนาคตไปด้วยกันนะ",
                image: ""
            }
        ];

        let currentSlide = 0;

        function initDeck() {
            // Setup dots
            const dotsContainer = document.getElementById('progress-dots');
            dotsContainer.innerHTML = '';
            storyChapters.forEach((_, idx) => {
                const dot = document.createElement('div');
                dot.className = `dot ${idx === 0 ? 'active' : ''}`;
                dot.onclick = () => goToSlide(idx);
                dotsContainer.appendChild(dot);
            });

            updateSlideUI();
        }

        function updateSlideUI() {
            const chapter = storyChapters[currentSlide];
            const polaroid = document.querySelector('.polaroid-card');
            
            // Apply slight random tilt/rotation for physical look
            const rot = (currentSlide % 2 === 0 ? -1.5 : 1.5) + (Math.random() * 0.4 - 0.2);
            polaroid.style.transform = `rotate(${rot}deg) translateY(-5px)`;
            
            // Fade out, swap text, fade back in
            polaroid.style.opacity = '0.3';
            
            setTimeout(() => {
                document.getElementById('chapter-title').innerText = chapter.chapter;
                document.getElementById('chapter-date').innerText = chapter.date;
                document.getElementById('polaroid-caption').innerText = chapter.text;

                const imgEl = document.getElementById('polaroid-img');
                const placeholderEl = document.querySelector('.photo-placeholder');

                if (chapter.image) {
                    imgEl.src = chapter.image;
                    imgEl.style.display = 'block';
                    placeholderEl.style.display = 'none';
                } else {
                    imgEl.style.display = 'none';
                    placeholderEl.style.display = 'flex';
                }

                // Update dots
                document.querySelectorAll('.dot').forEach((d, idx) => {
                    d.className = `dot ${idx === currentSlide ? 'active' : ''}`;
                });

                polaroid.style.opacity = '1';
                polaroid.style.transform = `rotate(${rot}deg) translateY(0)`;
            }, 250);
        }

        function nextSlide() {
            if (currentSlide < storyChapters.length - 1) {
                currentSlide++;
                updateSlideUI();
                playChime(600 + currentSlide * 50, 0.08);
            }
        }

        function prevSlide() {
            if (currentSlide > 0) {
                currentSlide--;
                updateSlideUI();
                playChime(600 + currentSlide * 50, 0.08);
            }
        }

        function goToSlide(idx) {
            currentSlide = idx;
            updateSlideUI();
            playChime(600 + currentSlide * 50, 0.08);
        }

        // Initialize on start
        window.addEventListener('DOMContentLoaded', initDeck);
```

- [ ] **Step 3: Commit**

```bash
git commit -a -m "feat: implement polaroid slides layout, data structure, and javascript nav engine"
```

---

### Task 3: Confetti Canvas Engine, Sound Effects, and Birthday Candle

**Files:**
- Modify: `index.html`

**Interfaces:**
- Consumes: Polaroid Stage.
- Produces: CSS Birthday candle blowing and canvas confetti animation at the end.

- [ ] **Step 1: Write Birthday Candle HTML, Canvas, and CSS**
Add the particle canvas, clean styling for the candle element, and insert it onto the final page slide structure.

Modify the CSS block to add:
```css
        /* --- FLOATING PARTICLES CANVAS --- */
        #particles-canvas {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            z-index: 0;
            pointer-events: none;
        }

        /* --- CANDLE WIDGET (MINIMAL CSS CANDLE) --- */
        .candle-container {
            display: none;
            flex-direction: column;
            align-items: center;
            margin-top: 15px;
            cursor: pointer;
            z-index: 5;
        }

        .candle-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.15rem;
            font-style: italic;
            color: var(--text-charcoal);
            margin-bottom: 20px;
        }

        .candle {
            width: 12px;
            height: 45px;
            background: linear-gradient(to right, #ffd166, #ff7096);
            border-radius: 3px 3px 0 0;
            position: relative;
        }

        .flame {
            width: 12px;
            height: 18px;
            background: radial-gradient(circle at bottom, #ffbe0b 20%, #fb5607 60%, rgba(251, 86, 7, 0) 100%);
            border-radius: 50% 50% 20% 20%;
            position: absolute;
            top: -20px;
            left: 50%;
            transform: translateX(-50%);
            box-shadow: 0 0 10px #ffbe0b, 0 0 20px #fb5607;
            animation: flicker 0.15s infinite alternate;
            transition: opacity 0.5s, transform 0.5s;
        }

        @keyframes flicker {
            0% { transform: translateX(-50%) scale(0.95) rotate(-1deg); }
            100% { transform: translateX(-50%) scale(1.05) rotate(1deg); }
        }

        .flame.blown {
            opacity: 0;
            transform: translateX(-50%) translateY(-10px) scale(0);
            pointer-events: none;
        }

        .candle-hint {
            font-size: 0.8rem;
            color: var(--text-muted);
            margin-top: 12px;
            font-style: italic;
        }
```

Insert the Canvas element in the body:
```html
    <!-- Add at the very top of <body> -->
    <canvas id="particles-canvas"></canvas>
```

Insert the Candle container structure in the HTML (e.g. directly below `#polaroid-caption` or inside the polaroid-card box):
```html
    <!-- Insert inside .polaroid-card, right after #polaroid-caption -->
    <div id="candle-stage" class="candle-container" onclick="blowCandle()">
        <h4 class="candle-title">เป่าเค้กวันเกิดตรงนี้อธิษฐานนะคนเก่ง 🎂</h4>
        <div class="candle">
            <div id="candle-flame" class="flame"></div>
        </div>
        <p id="candle-hint" class="candle-hint">แตะเปลวไฟเพื่อเป่าเทียนอธิษฐานกันนะ</p>
    </div>
```

- [ ] **Step 2: Add Confetti Particle script and update Nav trigger**
Add the particle engine logic and connect it to show on Slide 4.

Modify the JavaScript blocks to implement:
```javascript
        let audioCtx = null;
        let candleBlown = false;

        // Web Audio API Chime Synth
        function playChime(freq, duration) {
            try {
                if (!audioCtx) audioCtx = new (window.AudioContext || window.webkitAudioContext)();
                if (audioCtx.state === 'suspended') audioCtx.resume();

                const osc = audioCtx.createOscillator();
                const gain = audioCtx.createGain();

                osc.type = 'sine';
                osc.frequency.setValueAtTime(freq, audioCtx.currentTime);

                gain.gain.setValueAtTime(0.12, audioCtx.currentTime);
                gain.gain.exponentialRampToValueAtTime(0.001, audioCtx.currentTime + duration);

                osc.connect(gain);
                gain.connect(audioCtx.destination);

                osc.start();
                osc.stop(audioCtx.currentTime + duration);
            } catch (e) {}
        }

        // --- CONFETTI CANVAS PARTICLE SYSTEM ---
        const canvas = document.getElementById('particles-canvas');
        const ctx = canvas.getContext('2d');
        let particles = [];

        function resizeCanvas() {
            canvas.width = window.innerWidth;
            canvas.height = window.innerHeight;
        }
        window.addEventListener('resize', resizeCanvas);
        resizeCanvas();

        class ConfettiParticle {
            constructor(x, y) {
                this.x = x || Math.random() * canvas.width;
                this.y = y || -20;
                this.size = Math.random() * 6 + 4;
                this.color = ['#ff7096', '#ffbe0b', '#1db954', '#d4b2a7', '#ffffff'][Math.floor(Math.random() * 5)];
                this.speedX = Math.random() * 4 - 2;
                this.speedY = Math.random() * 3 + 2;
                this.rotation = Math.random() * 360;
                this.rotationSpeed = Math.random() * 10 - 5;
                this.opacity = 1;
            }

            update() {
                this.x += this.speedX;
                this.y += this.speedY;
                this.rotation += this.rotationSpeed;
                if (this.y > canvas.height) {
                    const idx = particles.indexOf(this);
                    if (idx > -1) particles.splice(idx, 1);
                }
            }

            draw() {
                ctx.save();
                ctx.translate(this.x, this.y);
                ctx.rotate(this.rotation * Math.PI / 180);
                ctx.fillStyle = this.color;
                ctx.globalAlpha = this.opacity;
                ctx.fillRect(-this.size / 2, -this.size / 2, this.size, this.size);
                ctx.restore();
            }
        }

        function animateParticles() {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            particles.forEach(p => {
                p.update();
                p.draw();
            });
            requestAnimationFrame(animateParticles);
        }
        animateParticles();

        function triggerConfetti() {
            for (let i = 0; i < 80; i++) {
                setTimeout(() => {
                    particles.push(new ConfettiParticle(canvas.width / 2, canvas.height * 0.4));
                }, i * 15);
            }
        }

        // Blow out candle
        function blowCandle() {
            if (candleBlown) return;
            const flame = document.getElementById('candle-flame');
            flame.classList.add('blown');
            candleBlown = true;
            document.getElementById('candle-hint').innerText = "คำอธิษฐานส่งถึงดวงดาวแล้วนะ 💖";
            
            // Play sweet chimes
            playChime(523.25, 0.2); // C5
            setTimeout(() => playChime(659.25, 0.2), 100); // E5
            setTimeout(() => playChime(783.99, 0.3), 200); // G5
            setTimeout(() => playChime(1046.50, 0.4), 300); // C6

            triggerConfetti();
        }

        // Update updateSlideUI logic to show candle container ONLY on the final slide
        // Insert this check at the end of the updateSlideUI function:
        /*
            const candleStage = document.getElementById('candle-stage');
            if (currentSlide === storyChapters.length - 1) {
                candleStage.style.display = 'flex';
            } else {
                candleStage.style.display = 'none';
            }
        */
```

Replace the complete `updateSlideUI` function inside the script block:
```javascript
        function updateSlideUI() {
            const chapter = storyChapters[currentSlide];
            const polaroid = document.querySelector('.polaroid-card');
            
            const rot = (currentSlide % 2 === 0 ? -1.5 : 1.5) + (Math.random() * 0.4 - 0.2);
            polaroid.style.transform = `rotate(${rot}deg) translateY(-5px)`;
            polaroid.style.opacity = '0.3';
            
            setTimeout(() => {
                document.getElementById('chapter-title').innerText = chapter.chapter;
                document.getElementById('chapter-date').innerText = chapter.date;
                document.getElementById('polaroid-caption').innerText = chapter.text;

                const imgEl = document.getElementById('polaroid-img');
                const placeholderEl = document.querySelector('.photo-placeholder');

                if (chapter.image) {
                    imgEl.src = chapter.image;
                    imgEl.style.display = 'block';
                    placeholderEl.style.display = 'none';
                } else {
                    imgEl.style.display = 'none';
                    placeholderEl.style.display = 'flex';
                }

                // Show candle only on final slide
                const candleStage = document.getElementById('candle-stage');
                if (currentSlide === storyChapters.length - 1) {
                    candleStage.style.display = 'flex';
                } else {
                    candleStage.style.display = 'none';
                }

                // Update dots
                document.querySelectorAll('.dot').forEach((d, idx) => {
                    d.className = `dot ${idx === currentSlide ? 'active' : ''}`;
                });

                polaroid.style.opacity = '1';
                polaroid.style.transform = `rotate(${rot}deg) translateY(0)`;
            }, 250);
        }
```

- [ ] **Step 3: Commit**

```bash
git commit -a -m "feat: integrate canvas particles, ambient synth chimes, and birthday candle blow interaction"
```
