from pydantic import BaseModel

class CardSchema(BaseModel):
    id: int
    question: str
    answer: str
    topic: str

    class Config:
        orm_mode = True

from pydantic import BaseModel

class ProgressCreate(BaseModel):
    user_id: str
    card_id: int
    status: str

class ProgressSchema(ProgressCreate):
    id: int

    class Config:
        from_attributes = True
