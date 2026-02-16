from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from supabase import create_client, Client
import os
from dotenv import load_dotenv

load_dotenv()

app = FastAPI(title="APL 2026 Analytics API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

url: str = os.getenv("SUPABASE_URL")
key: str = os.getenv("SUPABASE_SERVICE_ROLE_KEY")
supabase: Client = create_client(url, key)

@app.get("/")
def read_root():
    return {"message": "ALMA PREMIER LEAGUE 2026 - Backend Active"}

@app.get("/analytics/top-performers")
def get_top_performers():
    # Example complex logic that could be handled in Python
    # This could calculate MVP points based on a weighted formula
    players = supabase.table("players").select("*, batting_stats(*), bowling_stats(*)").execute()
    # Logic for calculating MVP points...
    return players.data

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
