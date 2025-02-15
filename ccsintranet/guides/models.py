from wagtail.fields import StreamField
from wagtail.admin.panels import FieldPanel
from ccsintranet.utils.models import BasePage
from ccsintranet.utils.blocks import StoryBlock

class GuidePage(BasePage):
    template = "pages/guide_page.html"

    body = StreamField(StoryBlock())

    content_panels = BasePage.content_panels + [
        FieldPanel("body"),
    ]
