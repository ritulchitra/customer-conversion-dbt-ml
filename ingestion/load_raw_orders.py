import os
import pandas as pd
from sqlalchemy import create_engine
from dotenv import load_dotenv
from urllib.parse import quote_plus

load_dotenv()

password = quote_plus(os.getenv("DB_PASSWORD"))

df = pd.read_csv(
    r"C:\Users\ritul\OneDrive\Desktop\Projects\customer-conversion-dbt-ml\data\Online_Retail.csv",
    encoding="ISO-8859-1"
)

# 🔥 THIS IS THE FIX — force correct column names
df.columns = [
    "InvoiceNo",
    "StockCode",
    "Description",
    "Quantity",
    "InvoiceDate",
    "UnitPrice",
    "CustomerID",
    "Country"
]

engine = create_engine(
    f"postgresql+psycopg2://{os.getenv('DB_USER')}:{password}"
    f"@{os.getenv('DB_HOST')}:{os.getenv('DB_PORT')}/{os.getenv('DB_NAME')}",
    connect_args={"sslmode": "require"}
)

df.to_sql(
    "raw_orders",
    engine,
    if_exists="append",
    index=False,
    chunksize=5000
)

print("raw_orders loaded successfully")
