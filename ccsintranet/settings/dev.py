from .base import *

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = "django-insecure-d1#v%s5br-_r+53#&3)f8#rgu)yd(ee_jhh2ms3az=wz^c7=yz"

# SECURITY WARNING: define the correct hosts in production!
ALLOWED_HOSTS = ["*"]

EMAIL_BACKEND = "django.core.mail.backends.console.EmailBackend"

DATABASES = {
    'default': dj_database_url.config(default="postgres://app_user:changeme@localhost:5434/app_db"),
}


try:
    from .local import *
except ImportError:
    pass
