from django.db import models
from wagtail.admin.panels import FieldPanel, InlinePanel, MultiFieldPanel
from wagtail.search import index

from wagtail.fields import StreamField
from ccsintranet.utils.blocks import StoryBlock, InternalLinkBlock, CTASectionBlock
from ccsintranet.utils.models import BasePage


class HomePage(BasePage):
    template = "pages/home_page.html"

    hero_title = models.TextField(blank=True)
    hero_subtitle = models.TextField(blank=True)

    news_title = models.TextField(blank=True)
    news_subtitle = models.TextField(blank=True)

    events_title = models.TextField(blank=True)
    events_subtitle = models.TextField(blank=True)

    guides_title = models.TextField(blank=True)
    guides_subtitle = models.TextField(blank=True)


    hero_cta = StreamField(
        [("link", CTASectionBlock())],
        blank=True,
        min_num=0,
        max_num=1,
    )

    content_panels = BasePage.content_panels + [
        FieldPanel("hero_title"),
        FieldPanel("hero_subtitle"),
        FieldPanel("hero_cta"),
        MultiFieldPanel(
            [
                InlinePanel(
                    "page_related_pages",
                    label="Featured pages",
                    max_num=4,
                ),
            ],
            heading="Featured pages section",
        ),
        FieldPanel("news_title"),
        FieldPanel("news_subtitle"),
        FieldPanel("events_title"),
        FieldPanel("events_subtitle"),
        FieldPanel("guides_title"),
        FieldPanel("guides_subtitle"),
    ]
