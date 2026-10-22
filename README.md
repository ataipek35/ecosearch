# EcoSearch – Sustainable Product & Alternative Search Engine

EcoSearch is a mobile search and comparison application built with Flutter that estimates the environmental impact of everyday consumer products and recommends certified, lower-carbon alternatives.

## 👥 Group Details (Group 23)
* **Course:** CS310 Mobile Application Development
* **Framework:** Flutter (Dart)
* **Assigned TA:** Zenia Mazhar
---

### Team Members
* **Ata İpek** – 34452
* **Zeynep Taşkın** – 33851
* **Hakan Osman Taşkın** – 22606

---

## 📱 App Overview & Problem Addressed
* **Problem:** Consumers want to purchase sustainable everyday items but face greenwashing, complex ingredient/certification details, and fragmented comparison processes across categories.
* **Solution:** EcoSearch bridges this gap by combining automated eco-impact estimation, verified eco-certifications, and clear alternatives into a single mobile workflow.
* **Target Audience:** Urban consumers aged 18–40, students, and conscious shoppers.
* **Scope Limit :** Three distinct product categories:
  1. Liquid soaps & chemical detergents
  2. T-shirts (apparel)
  3. Packaged foods

---

## Core Features
The application operates through an end-to-end flow: **Search ➔ Analyze ➔ Compare Alternatives ➔ Save**.

1. **Multi-Modal Product Input:**
   * Text search with autocomplete.
   * Barcode scanning.
   * Label/product photo upload (OCR + vision analysis).

2. **Eco-Impact Analysis:**
   * Approximate ranges for estimated carbon footprint and plastic packaging waste.

3. **Verified Certified Alternatives:**
   * Recommends certified greener alternatives retrieved from an official certification database via RAG.
   * Recognizes EU Ecolabel, FSC, Fairtrade, and Energy Star standards.

4. **Impact Scorecard:**
   * Side-by-side comparison displaying the current product's score against alternative cards (including approximate price, savings score, and official certification badges).

5. ** Reasoning:**
   * Explaining exactly why each recommended alternative is more sustainable.

6. **Local Storage & Offline Support:**
   * Favorites and search history stored locally on the device (via Hive or SQLite/drift).
   * Multi-language support (Turkish / English) and light/dark theme options.

---

## 🛠️ Data & Architecture
* **Frontend:** Flutter (Dart) targeting Android.
* **Local Persistence:** Hive / SQLite (stores search history, favorites, settings; does not store user photos).
* **External APIs:** Open Food Facts & Open Products Facts (for barcode metadata).
* **Backend & AI Layer:** Thin API layer (Firebase Cloud Functions / FastAPI) managing prompt construction, rate limits, RAG vector retrieval (pgvector), and multimodal LLM inference.

---

## ⚠️ Potential Challenges & Mitigations
* **Data Gaps:** If a barcode is missing from open databases, users can fall back to text search or capture a label photo.
* **Model Accuracy & Hallucinations:** Recommendations are strictly anchored to verified eco-label databases via RAG, and impact metrics are labeled as estimates.
* **Photo & OCR Quality:** If an uploaded label image is blurry, the app prompts the user to retake the photo or edit parsed text manually.
* **Inference Latency:** Frequently queried products and common alternatives are cached locally to ensure real-time UI performance.
* **Scope Management:** The project strictly limits development to three predefined categories to guarantee delivery within the semester.
