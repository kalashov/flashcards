import httpx
from sqlalchemy.orm import Session
from .models import Card

async def load_cards_from_opentdb(db: Session, amount: int = 10):
    url = f"https://opentdb.com/api.php?amount={amount}&type=multiple"

    async with httpx.AsyncClient() as client:
        response = await client.get(url)
        data = response.json()

    for item in data["results"]:
        question = item["question"]
        answer = item["correct_answer"]
        topic = item["category"]

        card = Card(question=question, answer=answer, topic=topic)
        db.add(card)

    db.commit()
