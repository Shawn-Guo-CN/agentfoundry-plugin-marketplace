# Python Architecture Patterns

## Project Structure Indicators

### Package Managers
- `pyproject.toml` - Modern Python (Poetry, PDM, Hatch)
- `setup.py` / `setup.cfg` - Traditional setuptools
- `requirements.txt` - pip dependencies
- `Pipfile` - Pipenv

### Common Architectures

**Django (MTV)**
```
project/
├── manage.py
├── project/
│   ├── settings.py
│   ├── urls.py
│   └── wsgi.py
└── apps/
    └── users/
        ├── models.py      # Data models
        ├── views.py       # Request handlers
        ├── serializers.py # API serialization
        └── urls.py        # Route definitions
```

**FastAPI (Layered)**
```
src/
├── main.py            # App entry
├── api/
│   └── routes/        # Endpoint handlers
├── core/
│   ├── config.py      # Settings
│   └── security.py    # Auth logic
├── models/            # Pydantic/SQLAlchemy
├── services/          # Business logic
└── repositories/      # Data access
```

**Domain-Driven Design**
```
src/
├── domain/
│   ├── entities/
│   └── value_objects/
├── application/
│   ├── commands/
│   └── queries/
├── infrastructure/
│   ├── persistence/
│   └── external/
└── interfaces/
    └── api/
```

## Key Files to Analyze

| File | Reveals |
|------|---------|
| `pyproject.toml` | Dependencies, build system, project metadata |
| `__init__.py` | Package structure, public exports |
| `conftest.py` | Test fixtures, shared test setup |
| `main.py` | Main entry, public use |
| `.env.example` | Configuration requirements |

## Patterns to Identify

### Dependency Injection
- `dependency-injector` library
- FastAPI's `Depends()` system
- Constructor injection in services

### ORM Patterns
- SQLAlchemy models and relationships
- Django ORM with managers
- Tortoise ORM async patterns

### API Patterns
- FastAPI routers with Pydantic models
- Django REST Framework viewsets
- Flask blueprints

### Async Patterns
- `async def` handlers
- Background tasks (Celery, RQ, ARQ)
- Event-driven (asyncio, aio-pika)

### Module Boundaries
- `__all__` defines public API
- Private modules prefixed with `_`
- Type stubs in `py.typed` or `.pyi` files
