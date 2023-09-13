from server.settings import INSTALLED_APPS, MIDDLEWARE

TEST_APPS = [
    "nplusone.ext.django",
]

TEST_MIDDLEWARE = [
    "nplusone.ext.django.NPlusOneMiddleware",
]


INSTALLED_APPS += TEST_APPS
MIDDLEWARE += TEST_MIDDLEWARE

NPLUSONE_RAISE = True
