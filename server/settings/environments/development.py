from server.settings import INSTALLED_APPS, MIDDLEWARE

DEVELOPMENT_APPS = [
    "nplusone.ext.django",
]

DEVELOPMENT_MIDDLEWARE = [
    "nplusone.ext.django.NPlusOneMiddleware",
]


INSTALLED_APPS += DEVELOPMENT_APPS
MIDDLEWARE += DEVELOPMENT_MIDDLEWARE

NPLUSONE_RAISE = True
