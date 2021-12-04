{include file="frontend/components/header.tpl" pageTitleTranslated=$currentJournal->getLocalizedName()}

{if $numAnnouncementsHomepage && $announcements|@count}
<!-- Announcements start -->
    <section class="mt-10">
        <div class="container mx-auto">
            <h2 class="font-bold text-2xl mb-4">Announcements</h2>

            {foreach name=announcements from=$announcements item=announcement}
            {if $smarty.foreach.announcements.iteration > $numAnnouncementsHomepage}
                {break}
            {/if}
            <!-- item start -->
            <div class="bg-white box-shadow p-6 rounded my-6">
                <p class="accent-color">{$announcement->getDatePosted()|date_format:$dateFormatShort}</p>
                <h3 class="text-black font-bold text-lg">
                    <a class="hover:text-gray-800" href="{url router=$smarty.const.ROUTE_PAGE page="announcement" op="view" path=$announcement->getId()}">{$announcement->getLocalizedTitle()|escape}</a>
                </h3>
                <p class="text-gray-700">{$announcement->getLocalizedDescriptionShort()|strip_unsafe_html}</p>
            </div>
            <!-- item end -->
            {/foreach}
    </section>
    <!-- Announcements end -->
    {/if}

    {if $issue}
    <!-- Current issue start -->
    <section class="mt-10">
        <div class="container mx-auto">
            <h2 class="font-bold text-2xl mb-4">Current Issue</h2>
            <div class="flex space-x-10">
                <!-- Issue cover start -->
                <div class="box-shadow rounded flex-2">
                    {assign var=issueCover value=$issue->getLocalizedCoverImageUrl()}
		            {if $issueCover}
                    <a class="hover:text-gray-800" href="{url op="view" page="issue" path=$issue->getBestIssueId()}">
                        <img class="w-full" src="{$issueCover|escape}" alt="{translate key="issue.viewIssueIdentification" identification=$issue->getIssueIdentification()|escape}">
                    </a>
                    {/if}
                </div>
                <!-- Issue cover end -->

                <!-- content start -->
                <div class="flex-1">
                    <div class="bg-white box-shadow p-6 rounded">
                        <h3 class="text-black font-bold text-lg">
                            {$issue->getIssueIdentification()|strip_unsafe_html}
                        </h3>

                        {if $issue->getDatePublished()}
                        <p class="accent-color">
                            <span class="font-bold">{translate key="submissions.published"}:</span> {$issue->getDatePublished()|date_format:$dateFormatShort}
                        </p>
                        {/if}

                        {* PUb IDs (eg - DOI) *}
                        {foreach from=$pubIdPlugins item=pubIdPlugin}
                            {assign var=pubId value=$issue->getStoredPubId($pubIdPlugin->getPubIdType())}
                            {if $pubId}
                                {assign var="doiUrl" value=$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
                                <div class="pub_id {$pubIdPlugin->getPubIdType()|escape}">
                                    <span class="type">
                                        {$pubIdPlugin->getPubIdDisplayType()|escape}:
                                    </span>
                                    <span class="id">
                                        {if $doiUrl}
                                            <a href="{$doiUrl|escape}">
                                                {$doiUrl}
                                            </a>
                                        {else}
                                            {$pubId}
                                        {/if}
                                    </span>
                                </div>
                            {/if}
                        {/foreach}

                        {* Description *}
                        {if $issue->hasDescription()}
                            <p>
                                {$issue->getLocalizedDescription()|strip_unsafe_html}
                            </p>
                        {/if}
                    </div>
                </div>
                <!-- content end -->
            </div>
    </section>
    <!-- Current issue end -->
    {/if}

    {foreach name=sections from=$publishedSubmissions item=section}
    {if $section.articles}
    <!-- Articles start -->
    <section class="mt-10">
        <div class="container mx-auto">
            {if $section.title} 
            <h2 class="font-bold text-2xl mb-4">{$section.title|escape}</h2>
            {/if}

            {foreach name="ami" from=$section.articles item=article}
            <!-- item start -->
            <div class="bg-white box-shadow p-6 rounded my-6">
                {assign var=articlePath value=$article->getBestId()}
                <h3 class="text-black font-bold text-lg"><a class="hover:text-gray-800" {if $journal}href="{url journal=$journal->getPath() page="article" op="view" path=$articlePath}"{else}href="{url page="article" op="view" path=$articlePath}"{/if}>{$article->getLocalizedTitle()|strip_unsafe_html}</a></h3>
                
                {if $article->getLocalizedSubtitle()}
                <p class="text-gray-700">{$article->getLocalizedSubtitle()|escape}</p>
                {/if}

                {if $showAuthor}
                <p class="authors">
                    {$article->getAuthorString()|escape}
                </p>
                {/if}

                {* Page numbers for this article *}
                {if $article->getPages()}
                    <p class="pages">
                        {$article->getPages()|escape}
                    </p>
                {/if}

                {if $showDatePublished && $article->getDatePublished()}
                    <div class="published">
                        {$article->getDatePublished()|date_format:$dateFormatShort}
                    </div>
                {/if}
                
                {if !$hideGalleys}
                <ul class="galleys_links">
                    {foreach from=$article->getGalleys() item=galley}
                        {if $primaryGenreIds}
                            {assign var="file" value=$galley->getFile()}
                            {if !$galley->getRemoteUrl() && !($file && in_array($file->getGenreId(), $primaryGenreIds))}
                                {continue}
                            {/if}
                        {/if}
                        <li class="mt-2 article-gallery-li">
                            {assign var="hasArticleAccess" value=$hasAccess}
                            {if $currentContext->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_OPEN || $publication->getData('accessStatus') == $smarty.const.ARTICLE_ACCESS_OPEN}
                                {assign var="hasArticleAccess" value=1}
                            {/if}
                            {include file="frontend/objects/galley_link.tpl" parent=$article labelledBy="article-{$article->getId()}" hasAccess=$hasArticleAccess purchaseFee=$currentJournal->getData('purchaseArticleFee') purchaseCurrency=$currentJournal->getData('currency')}
                        </li>
                    {/foreach}
                </ul>
                {/if}
            </div>
            <!-- item end -->
            {/foreach}
    </section>
    <!-- Articles end -->
    {/if}
    {/foreach}

    {include file="frontend/components/footer.tpl"}