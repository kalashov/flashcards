from sqlalchemy import Column, Integer, String
from .database import Base

class Card(Base):
    __tablename__ = "cards"

    id = Column(Integer, primary_key=True, index=True)
    question = Column(String, nullable=False)
    answer = Column(String, nullable=False)
    topic = Column(String, nullable=False)

from sqlalchemy import ForeignKey

class Progress(Base):
    __tablename__ = "progress"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(String, index=True)
    card_id = Column(Integer, ForeignKey("cards.id"))
    status = Column(String)  # "know" или "dont_know"
