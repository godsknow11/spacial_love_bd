# Design Spec: Minimalist Polaroid Storybook Birthday SPA

A clean, elegant, single-page application (SPA) acting as an interactive birthday card template. The design centers around a Polaroid card that guides the reader through four chapters of a personal story, ending with a minimal candle-blowing interactive element.

## Visual Design System

### Colors & Palette
- Background: `#fcfaf6` (Warm cream/beige)
- Text Main: `#2a2927` (Charcoal gray)
- Text Muted: `#7a7772` (Soft gray)
- Rose Gold Borders/Accents: `#d4b2a7`
- Hover/Active State: `#e5c1b5`
- Card Background: `#ffffff`

### Typography
- Primary Font: `'Sarabun'`, sans-serif (Google Fonts)
- Elegant Accents/Headers: `'Playfair Display'`, serif (Google Fonts, italicized)

---

## Page Layout & Component Structure

### 1. Cover Screen (`#cover-screen`)
A simple, centered minimalist envelope card.
- Text: `"ถึง... คนพิเศษของใจ 💌"`
- Subtext: `"คุณได้รับจดหมายฉบับพิเศษ"`
- Interaction: Clicking triggers a fade-out animation and reveals the Polaroid stage.

### 2. Polaroid Stage (`#story-stage`)
A centered, responsive container styled as a classic Polaroid photo card.
- **Top Part**: Photo placeholder box (`.polaroid-photo-frame`).
  - Styled with a thin dashed border.
  - Displays placeholder text: `[ ลากรูปภาพของคุณมาใส่ที่นี่ / Insert Photo Here ]`
  - Responsive height, preserving a 4:3 or 1:1 photo aspect ratio.
- **Middle Part**: Date & Chapter Header (`.polaroid-meta`).
  - Font: Playfair Display, italic.
  - Text: `"June 2026 — Chapter 01"`
- **Bottom Part**: Story text paragraph (`.polaroid-caption`).
  - Font: Sarabun.
  - Text: The custom paragraph for each chapter.
- **Navigation Controls**:
  - Left & Right thin line arrow buttons (`#prev-btn` and `#next-btn`).
  - Dots indicator at the bottom (`.progress-dots`).

### 3. Interactive Birthday Wish (`#wish-stage`)
- Appears on the final slide of the deck.
- Features a simple, vector-drawn CSS birthday candle.
- Interaction: Clicking the candle blows out the flame, triggers a canvas confetti explosion, and reveals a final congratulations banner.

---

## Data Structure: The 4 Story Chapters

```json
[
  {
    "chapter": "Chapter 01",
    "date": "Our Journey",
    "text": "ปีนี้เป็นปีที่เราสองคนผ่านเรื่องราวอะไรด้วยกันมาเยอะมากจริงๆ มีทั้งรอยยิ้มและเรื่องราวต่างๆ แต่สุดท้ายเราก็ผ่านมาด้วยกันได้",
    "image": "assets/stormy_umbrella.png"
  },
  {
    "chapter": "Chapter 02",
    "date": "Health & Care",
    "text": "ปีนี้เห็นเธอป่วยบ่อย เค้าเป็นห่วงมากๆ เลยนะ ไม่อยากเห็นเธอป่วยเลย อยากให้เธอแข็งแรงและอยู่กับเค้าไปนานๆ ไม่ว่าวันข้างหน้าจะเป็นยังไง ขอให้รู้ไว้ว่าเค้าจะคอยอยู่ข้างๆ เธอเสมอ",
    "image": "assets/cozy_together.png"
  },
  {
    "chapter": "Chapter 03",
    "date": "Our Promise",
    "text": "และปีนี้... คำสัญญาของเราเป็นจริงแล้วนะ ที่เค้าได้ไปหมั้นเธอ ดีใจหรือเปล่า? เป้าหมายต่อไปของเราคือ 'งานแต่งงาน' (แล้วก็พากันกินให้อ้วน 555 แหย่เล่นน้า) เค้าคิดถึงเป้าหมายนี้ทุกวันเลย อยากแต่งงานกับเธอเร็วๆ จัง สงสัยต้องรีบลุยหาเงินมาแต่งซะแล้วสิ",
    "image": "assets/starry_future.png"
  },
  {
    "chapter": "Chapter 04",
    "date": "Together Forever",
    "text": "เนื่องในวันเกิดอายุครบ 26 ปีบริบูรณ์ของเธอ เค้าขอให้ที่รักสุขภาพร่างกายแข็งแรง ไม่เจ็บไม่ป่วย หันมาดูแลตัวเองและออกกำลังกายเยอะๆ นะ ถ้ามีเรื่องอะไรไม่สบายใจ หันมาบอกเค้าได้ทุกเรื่องเลย เค้าพร้อมจะอยู่ตรงนี้ เป็นที่พักพิงให้เธอได้บ่นตลอดไปเลยนะ เรามาพยายามสร้างครอบครัวและอนาคตไปด้วยกันนะ",
    "image": ""
  }
]
```
*(Note: If a chapter does not have an image path or the image is missing, the template will display a beautiful placeholder graphic).*
