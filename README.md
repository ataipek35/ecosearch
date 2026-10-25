# EcoSearch – Sustainable Product & Alternative Search Engine

EcoSearch is a mobile search and comparison application built with Flutter that estimates the environmental impact of everyday consumer products and recommends lower-impact alternatives.

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
* **Problem:** Consumers want to purchase sustainable everyday items but face dense ingredient/certification details and the time needed to compare alternatives. Existing apps mostly give a score without alternatives.
* **Solution:** EcoSearch bridges this gap by combining eco-impact estimation, alternatives, and an AI-written explanation into a single mobile workflow. In a later phase, alternatives are matched against verified EU Ecolabel records.
* **Target Audience:** Urban consumers aged 18–40, students, and conscious shoppers.
* **Scope Limit :** Three distinct product categories:
  1. Liquid soaps & chemical detergents
  2. T-shirts (apparel)
  3. Packaged foods

---

## Core Features
The application operates through an end-to-end flow: **Search ➔ Analyze ➔ Compare Alternatives ➔ Save**.

1. **Product Input:**
   * Text search with autocomplete.
   * Barcode scanning.

2. **Eco-Impact Analysis:**
   * Approximate ranges for estimated carbon footprint (kg CO2e) and plastic packaging waste (g), based on product data fields and category averages.

3. **Impact Scorecard:**
   * Side-by-side comparison displaying the current product's score against alternative cards (including savings score and badges where data exists).

4. **AI Explanation:**
   * A text-based AI model explains the score and why each suggested alternative is greener, using only the retrieved product data.

5. **Local Storage & Offline Support:**
   * Favorites and search history stored locally on the device (via Hive or SQLite/drift).
   * Multi-language support (Turkish / English) and light/dark theme options.

6. **Planned if time permits:**
   * Verified certified alternatives retrieved from EU Ecolabel records via RAG, starting with one category.
---

## 🛠️ Data & Architecture
* **Frontend:** Flutter (Dart) targeting Android.
* **Local Persistence:** Hive / SQLite (stores search history, favorites, cached results, settings; does not store user photos).
* **External APIs:** Open Food Facts & Open Products Facts (for barcode and product metadata). EU Ecolabel records as the certification knowledge base in the later phase.
* **Backend & AI Layer:** Thin API layer (Firebase Cloud Functions / FastAPI) managing product data fetching, prompt construction, rate limits, and text-based LLM inference. AI keys stay on the backend, never in the client. Results return as JSON.

---

## ⚠️ Potential Challenges & Mitigations
* **Data Gaps:** If a barcode or product is missing from open databases, the app shows category-level fallback suggestions and clearly displays "no data".
* **Model Accuracy & Hallucinations:** The AI only explains records retrieved from data sources, with negative constraints in the prompt and source links. Impact metrics are shown as ranges labeled as estimates, and the app is not a scientific LCA.
* **Scope Management:** The MVP is limited to text search, barcode scanning, the scorecard, AI explanation, and two categories. RAG and extras come later.
* **Inference Latency & Cost:** Results are cached and requests are rate-limited, with a short JSON output schema and text-only LLM calls (target < 10 s)
* **Barcode Integration:** Uses mobile_scanner, handles camera permission, and stores no images.
