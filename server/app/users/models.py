from django.contrib.auth import models as auth_models
from django.db import models
from django.utils.translation import gettext_lazy as _


class User(auth_models.AbstractUser):
    email = models.EmailField(_("email address"), unique=True)
