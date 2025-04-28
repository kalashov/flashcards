from .utils import load_cards_from_opentdb
from fastapi import FastAPI, Depends
from sqlalchemy.orm import Session
from . import models, schemas
from .database import SessionLocal, engine
from .models import Card, Progress
from .schemas import CardSchema, ProgressSchema, ProgressCreate

models.Base.metadata.create_all(bind=engine)

app = FastAPI()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.get("/cards", response_model=list[schemas.CardSchema])
def read_cards(db: Session = Depends(get_db)):
    return db.query(models.Card).all()

@app.get("/")
def root():
    return {"message": "Flashcards API is running"}

@app.post("/load_cards")
async def load_cards(db: Session = Depends(get_db)):
    await load_cards_from_opentdb(db)
    return {"message": "Cards loaded successfully"}

@app.post("/progress", response_model=ProgressSchema)
def create_progress(progress: ProgressCreate, db: Session = Depends(get_db)):
    db_progress = Progress(**progress.dict())
    db.add(db_progress)
    db.commit()
    db.refresh(db_progress)
    return db_progress

@app.get("/progress", response_model=list[ProgressSchema])
def read_progress(user_id: str, db: Session = Depends(get_db)):
    return db.query(Progress).filter(Progress.user_id == user_id).all()
