from django.db import models
from wagtail.fields import StreamField
from wagtail.admin.panels import FieldPanel
from ccsintranet.utils.models import BasePage
from ccsintranet.utils.blocks import StoryBlock, LinkStreamBlock

class GuidePage(BasePage):
    template = "pages/guide_page.html"

    subtitle = models.TextField(blank=True)

    navigation = StreamField(LinkStreamBlock(), blank=True, min_num=0)

    body = StreamField(StoryBlock())

    content_panels = BasePage.content_panels + [
        FieldPanel("subtitle"),
        FieldPanel("navigation"),
        FieldPanel("body"),
    ]
