# как запустить бэкенд

1. Установить зависимости:
pip install -r requirements.txt

2. Поднять базу данных PostgreSQL через Docker:
docker run --name flashcards-db -e POSTGRES_PASSWORD=postgres -p 5433:5432 -d postgres

3. Запустить сервер FastAPI:
uvicorn app.main:app --reload

4. Перейти на:
- http://127.0.0.1:8000/ — API работает
- http://127.0.0.1:8000/docs — документация Swagger

5. Загрузить карточки:
- В Swagger интерфейсе (по ссылке выше) найти эндпоинт POST /load_cards.
- Нажать "Try it out" → "Execute".
- В базу загрузятся карточки с Open Trivia Database.