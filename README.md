# Project Link
https://app.fabric.microsoft.com/links/LEmKnCtHwu?ctid=b1ecfa5f-bf5c-4d47-8691-c39477ec0ac6&pbi_source=linkShare&bookmarkGuid=008438a7-121e-442a-bc16-b931ec4149a4
<img width="1341" height="720" alt="Screenshot_10-11-2026_14450_app fabric microsoft com" src="https://github.com/user-attachments/assets/5423e78d-c356-4fb3-a4d4-e6d3cbf1ac8d" />


# Cheltenham Festival 2026 Racing Intelligence Platform (Microsoft Fabric Gen2)

An enterprise data warehousing and sports analytics solution built on **Microsoft Fabric Synapse Data Warehouse (Gen2)**. This project models 2026 Cheltenham Festival race results, runner metrics, and betting market prices through a dimensional Star Schema, serving an interactive racing intelligence dashboard in Power BI via high-performance **Direct Lake** mode with zero data refresh lag.

---

## 1. System Architecture & End-to-End Pipeline

The platform follows a modern Lakehouse-to-Warehouse architecture natively within Microsoft Fabric:

1. **Ingestion & Data Preparation:** Raw race cards, runners, finishing positions, official starting prices (SP), and prize funds are ingested into Microsoft Fabric.
2. **Fabric Synapse Data Warehouse (Gen2):** Ingestion pipelines stage and load data into decoupled, serverless Delta storage in OneLake under a structured dimensional model.
3. **Dimensional Star Schema:** Clean separation of business entities into five dimension tables (`Dim_Date`, `Dim_Race`, `Dim_Trainer`, `Dim_Jockey`, `Dim_Horse`) connected to a centralized fact table (`Fact_Race_Runner`).
4. **Direct Lake Semantic Modeling:** A custom semantic model binds directly to the Delta tables in OneLake, allowing Power BI to query the warehouse directly in-memory without data duplication or import refresh schedules.
5. **Racing Intelligence Suite:** An executive dark-themed Power BI report delivering dynamic trainer spotlights, jockey leaderboard rankings, and starting price market efficiency analysis.

---

## 2. Dimensional Data Warehouse Design (Star Schema)

The warehouse implements a 6-table dimensional model designed for rapid aggregation across racing classifications, trainers, jockeys, and historical festival days:

### Schema Relationships
* `Dim_Date` (1) ───< `Fact_Race_Runner` (DateKey)
* `Dim_Race` (1) ───< `Fact_Race_Runner` (RaceKey)
* `Dim_Trainer` (1) ───< `Fact_Race_Runner` (TrainerKey)
* `Dim_Jockey` (1) ───< `Fact_Race_Runner` (JockeyKey)
* `Dim_Horse` (1) ───< `Fact_Race_Runner` (HorseKey)

### Table Structures

| Table | Type | Key Columns | Description |
| :--- | :--- | :--- | :--- |
| `Dim_Date` | Dimension | `DateKey`, `RaceDate`, `DayName`, `FestivalDayName` | Calendar and official festival days (Day 1 - Champion Day through Day 4 - Gold Cup Day). |
| `Dim_Race` | Dimension | `RaceKey`, `RaceId`, `RaceTitle`, `RaceTime`, `RaceGrade`, `RaceType`, `DistanceFurlongs`, `TotalPrizeFund` | Race metadata, distances, jump types (Hurdle vs. Chase), and prize money purses. |
| `Dim_Trainer` | Dimension | `TrainerKey`, `TrainerName`, `Country` | Trainer profiles and regional jurisdiction (Ireland vs. United Kingdom). |
| `Dim_Jockey` | Dimension | `JockeyKey`, `JockeyName` | Jockey roster. |
| `Dim_Horse` | Dimension | `HorseKey`, `HorseName`, `Age`, `Sex` | Horse attributes, age profile, and classification. |
| `Fact_Race_Runner` | Fact | `RunnerFactKey`, `FinishingPosition`, `StartingPrice`, `DecimalOdds`, `ImpliedProbability`, `IsWinner`, `IsPlaced`, `PrizeMoneyWon` | Grain: One row per horse per race entry, capturing market price, implied odds, finish position, and payout allocations. |

---

## 3. Direct Lake Semantic Modeling & DAX Intelligence

Calculations are modeled directly in the semantic layer to compute performance metrics and return-on-investment across the field:

* **Championship Winners Count:** Aggregates total first-place finishes across race categories.
* **Win Strike Rate (%):** Calculates winning efficiency by dividing total victories by total entries per trainer or jockey.
* **Level Stakes Profit/Loss (£1 LSP):** Simulates a standardized betting strategy of placing a flat £1 win stake on every runner, highlighting market inefficiencies and high-value longshot winners.
* **Total Prize Fund Secured:** Tracks cumulative purses earned across Grade 1 and handicap competitions.
* **Dynamic Spotlight Header:** A context-aware card measure that surfaces contextual metrics for the selected festival day or trainer, dynamically switching to executive summary mode when no single entity is filtered.

---

## 4. Power BI Presentation Layer

The visual console employs a high-contrast dark theme designed for executive analysis and live sports broadcasts:

* **Dynamic Festival Spotlight Card:** A top banner highlighting the selected festival day, analyzed championship races, or individual trainer career totals and net returns.
* **Jockey & Trainer Leaderboard (Horizontal Bar Chart):** Compares total festival wins, win strike rates, level stakes profit/loss, and prize money won across top connections.
* **Market Outlier Matrix (Scatter Plot):** Plots official starting price decimal odds against final finishing positions, color-coded by country (IRE vs. UK) to pinpoint massive market upsets and value winners across the festival.
* **Festival Navigation Slicers:** Tile selectors for festival days (Champion Day, Ladies Day, St. Patrick's Day, Gold Cup Day) and race grades (Grade 1 vs. Handicap) for targeted cross-filtering across the entire dashboard.

---

## 5. Fabric Platform Artifacts Reference

* **Fabric Synapse Data Warehouse Gen2 (`dw_warehouse_chelt`):** Centralized Delta-Parquet storage and Star Schema relational layer in OneLake.
* **Dataflow Gen2 Pipeline:** Automated transformation engine handling type casting, odds conversion, and Delta table loading.
* **Direct Lake Semantic Model:** High-throughput in-memory semantic layer linking warehouse Delta tables to reporting visuals.
* **Power BI Racing Intelligence Console:** Interactive dark layout tracking strike rates, market inefficiencies, and championship honors.
