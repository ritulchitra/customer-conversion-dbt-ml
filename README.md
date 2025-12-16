# Customer Conversion Prediction using dbt & Machine Learning

## 📌 Project Overview

This project demonstrates an **end-to-end analytics engineering + machine learning pipeline** built on real transactional data.

The goal is to predict whether a customer is likely to **convert (make a recent purchase)** based on historical purchasing behavior, using:

- **dbt** for analytics engineering and feature creation  
- **Python & scikit-learn** for machine learning  
- **Supabase (PostgreSQL)** as the data warehouse  

The project mirrors how **modern data teams** structure production-grade ML pipelines.

---

## 🎯 Problem Statement

Raw customer transaction data is often noisy, inconsistent, and not directly usable for machine learning.

**Objective:**
- Transform raw transactional data into **ML-ready customer features** using dbt
- Train and evaluate machine learning models to predict **customer conversion**
- Demonstrate how analytics engineering and ML integrate in real-world systems

---

## 📊 Dataset

**Online Retail Dataset (UCI / Kaggle)**  
Historical e-commerce transactions (2010–2011) with ~500K rows.

---

## 🏗️ Architecture

Raw CSV → Supabase (Postgres) → dbt (staging → features) → ML pipeline

---

## 🔍 Model Interpretation & Feature Impact Analysis

An additional analysis notebook was created to understand feature impact and prevent data leakage.

Notebook:
ml/notebooks/02_model_interpretation.ipynb

---

## 🧪 Features Used for Training

- total_orders  
- total_spend  
- avg_order_value  

These represent stable frequency and monetary behavior.

---

## ❌ Why `customer_id` Was Dropped

- It is a unique identifier, not a behavioral signal  
- Causes memorization, not generalization  

Identifiers should never be used as ML features.

---

## ❌ Why `recency_days` Was Dropped (Label Leakage)

Target definition:

converted = 1 if recency_days ≤ 30 else 0

Including recency_days leaked the label into the model, producing unrealistically perfect scores.

### Fix Applied
- Removed recency_days from training features
- Retrained models with cross-validation

---

## 📊 Feature Importance (Random Forest)

- total_orders → strongest signal  
- total_spend → second strongest  
- avg_order_value → supporting signal  

This aligns with business intuition.

---

## 📈 Final Model Performance

| Model | ROC-AUC (Mean) | Std Dev |
|------|---------------|--------|
| Logistic Regression | ~0.759 | ~0.015 |
| Logistic + Scaling | ~0.761 | ~0.016 |
| **Random Forest (Final)** | **~0.774** | **~0.017** |

---

## 🧠 Key Takeaway

This project prioritizes **correct ML practices**:
- Data leakage detection & fix
- Reproducible features via dbt
- Interpretable modeling decisions

---

## 🧪 Reproducibility

- Feature logic versioned in dbt
- ML experiments reproducible via notebooks
- Final model saved at:

ml/models/random_forest.joblib

---

## 🎯 Why This Matters

This project reflects **real-world ML standards**, not toy experiments.
