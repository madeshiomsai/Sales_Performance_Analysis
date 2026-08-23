# 📊 Superstore Sales & Profit Analysis

An end-to-end data analytics project covering **Python**, **SQL**, and **Power BI** — built on the
Sample Superstore dataset (9,994 US retail orders, 2014–2017).

The pipeline: raw Excel → cleaned & feature-engineered data (Python) → structured querying (SQLite
→ SQL Server) → an interactive 3-page Power BI dashboard.

---

## 🗂️ Repository Structure

```
├── data/
│   ├── Sample_Superstore.xls          # Original raw dataset (9,994 rows, 21 columns)
│   └── Superstore_Cleaned.csv         # Cleaned dataset with engineered features (27 columns)
├── notebooks/
│   └── Superstore_Analysis.ipynb      # Data cleaning, EDA, SQLite querying, SQL Server upload
├── sql/
│   ├── superstore_queries.sql         # Query library (SQLite syntax)
│   └── superstore_queries_sqlserver.sql  # Same queries, T-SQL / SQL Server syntax
├── database/
│   └── superstore.db                  # SQLite database (generated from the notebook)
├── powerbi/
│   └── Superstore_Performance_Dashboard.pbix   # Final 3-page Power BI dashboard
├── docs/
│   └── PowerBI_Beginner_StepByStep.md # Full click-by-click Power BI build guide
└── assets/
    ├── dashboard_overview.png
    ├── dashboard_profitability.png
    └── dashboard_customers.png
```

*(Adjust the paths above to match however you actually organize the repo — this is just a suggested layout.)*

---

## 🎯 Project Overview

This project answers common retail analytics questions using a full data stack:

1. **Python (Pandas, Jupyter)** — clean the raw data, engineer new features, and explore it visually
2. **SQL (SQLite → SQL Server)** — load the cleaned data into a real relational database and answer business questions with queries
3. **Power BI** — build an interactive, filterable dashboard connected live to SQL Server

---

## 🛠️ Tech Stack

| Layer | Tools |
|---|---|
| Data cleaning & EDA | Python, Pandas, Matplotlib, Seaborn, Jupyter Notebook |
| Database | SQLite (local/dev), Microsoft SQL Server (production-style) |
| Data upload | `pyodbc`, `SQLAlchemy` |
| Dashboard | Power BI Desktop, DAX |

---

## 📈 Dashboard Preview

**Page 1 — Executive Overview**
KPI cards, monthly sales & profit trend, category breakdown, customer segment split, regional sales.

![Executive Overview](assets/dashboard_overview.png)

**Page 2 — Profitability**
Sub-category profit (loss-makers highlighted), discount-vs-profit relationship, category margin comparison.

![Profitability](assets/dashboard_profitability.png)

**Page 3 — Customers & Operations**
Top 10 customers by sales, shipping speed and order volume by ship mode.

![Customers & Operations](assets/dashboard_customers.png)

All three pages share synced **Year / Region / Category** slicers, so filtering on one page updates all three.

---

## 🔑 Key Insights

- **Furniture underperforms on margin** — 2nd-highest sales ($742K) but by far the lowest profit ($18.5K, ~2.5% margin), while Technology and Office Supplies convert sales to profit far more efficiently (17%+ margin each).
- **Tables are a consistent loss-maker** — the single worst sub-category at **−$17.7K** profit, the main driver of Furniture's weak margin.
- **The West region leads on both fronts** — highest sales ($725K) *and* highest profit ($108K).
- **Sales grew every year**, from $484K (2014) to $733K (2017), with profit trending upward alongside it.
- Higher discount rates correlate with negative profit — several orders discounted 40%+ result in losses regardless of category.

---

## 🚀 Getting Started

### 1. Clone the repo
```bash
git clone https://github.com/<your-username>/superstore-analysis.git
cd superstore-analysis
```

### 2. Set up the Python environment
```bash
pip install pandas numpy matplotlib seaborn pyodbc sqlalchemy openpyxl
```

### 3. Run the notebook
Open `notebooks/Superstore_Analysis.ipynb` in Jupyter and run all cells. This will:
- Clean the raw data and engineer new features
- Generate the EDA charts
- Create a local SQLite database (`superstore.db`)
- *(Optional)* Upload the cleaned data to a SQL Server instance

### 4. Query the data
Run the queries in `sql/superstore_queries.sql` (SQLite) or `sql/superstore_queries_sqlserver.sql`
(SQL Server) against your database of choice.

### 5. Open the dashboard
Open `powerbi/Superstore_Performance_Dashboard.pbix` in **Power BI Desktop**. If you're connecting
to your own SQL Server instance, update the data source under `Home → Transform Data → Data Source
Settings`.

> New to Power BI? See [`docs/PowerBI_Beginner_StepByStep.md`](docs/PowerBI_Beginner_StepByStep.md)
> for a full click-by-click walkthrough — from opening Power BI to saving the finished `.pbix`.

---

## 📦 Dataset

**Source:** Sample Superstore dataset (commonly used for BI/analytics practice)
**Size:** 9,994 orders · 2014–2017 · United States
**Fields:** Order/Ship dates, Customer, Segment, Region, Product Category/Sub-Category, Sales,
Quantity, Discount, Profit, and more.

---

## 📄 License

*(Add your license here — e.g. MIT, or "For educational/portfolio use only" if this is a learning project.)*
