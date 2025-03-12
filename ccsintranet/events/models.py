from django.conf import settings
from django.db import models
from django.db.models.functions import Coalesce
from django.core.paginator import Paginator
from datetime import datetime
from wagtail.fields import StreamField
from wagtail.admin.panels import FieldPanel, HelpPanel, InlinePanel, MultiFieldPanel
from ccsintranet.utils.models import BasePage
from ccsintranet.utils.blocks import ImageBlock, StoryBlock
from wagtail.search import index
from wagtail.fields import RichTextField

class EventPage(BasePage):
    template = "pages/event_page.html"

    image = StreamField(
        [("image", ImageBlock())],
        blank=True,
        max_num=1,
    )

    category = models.CharField(max_length=255)
    location = models.CharField(max_length=255)
    start_at = models.DateTimeField(
        verbose_name="Start date/time", default=datetime.now
    )
    end_at = models.DateTimeField(verbose_name="End date/time", default=datetime.now)

    body = StreamField(StoryBlock())

    content_panels = BasePage.content_panels + [
        FieldPanel("image"),
        FieldPanel("category"),
        FieldPanel("location"),
        FieldPanel("start_at"),
        FieldPanel("end_at"),
        FieldPanel("body"),
    ]

class EventsListingPage(BasePage):
    template = "pages/event_listing_page.html"
    subpage_types = ["events.EventPage"]
    max_count = 1  # Allow only one events listing page to keep event pages in one place

    introduction = RichTextField(
        blank=True, features=["bold", "italic", "link"]
    )

    search_fields = BasePage.search_fields + [index.SearchField("introduction")]

    content_panels = (
        BasePage.content_panels
        + [
            FieldPanel("introduction"),
            HelpPanel("This page will automatically display child Event pages."),
        ]
    )

    def paginate_queryset(self, queryset, request):
        """Paginate the queryset."""
        page_number = request.GET.get("page", 1)
        paginator = Paginator(queryset, settings.DEFAULT_PER_PAGE)
        try:
            page = paginator.page(page_number)
        except PageNotAnInteger:
            page = paginator.page(1)
        except EmptyPage:
            page = paginator.page(paginator.num_pages)
        return (paginator, page, page.object_list, page.has_other_pages())


    def get_context(self, request, *args, **kwargs):
        context = super().get_context(request, *args, **kwargs)
        queryset = (
            EventPage.objects.live()
            .public()
            .order_by("-start_at")
        )

        # Paginate event pages
        paginator, page, _object_list, is_paginated = self.paginate_queryset(
            queryset, request
        )
        context["paginator"] = paginator
        context["paginator_page"] = page
        context["is_paginated"] = is_paginated

        return context
