from django.db import models
from datetime import datetime
from wagtail.fields import StreamField
from wagtail.admin.panels import FieldPanel
from ccsintranet.utils.models import BasePage
from ccsintranet.utils.blocks import StoryBlock

class EventPage(BasePage):
    template = "pages/event_page.html"

    feature_image = models.ForeignKey(
        'wagtailimages.Image',
        null=True,
        blank=True,
        on_delete=models.SET_NULL,
        related_name='+'
    )
    category = models.CharField(max_length=255)
    location = models.CharField(max_length=255)
    start_at = models.DateTimeField(
        verbose_name="Start date/time", default=datetime.now
    )
    end_at = models.DateTimeField(verbose_name="End date/time", default=datetime.now)

    body = StreamField(StoryBlock())

    content_panels = BasePage.content_panels + [
        FieldPanel("feature_image"),
        FieldPanel("body"),
    ]
