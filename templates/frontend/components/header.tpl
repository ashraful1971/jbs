{**
 * lib/pkp/templates/frontend/components/header.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Common frontend site header.
 *
 * @uses $isFullWidth bool Should this page be displayed without sidebars? This
 *       represents a page-level override, and doesn't indicate whether or not
 *       sidebars have been configured for thesite.
 *}
{strip}
	{* Determine whether a logo or title string is being displayed *}
	{assign var="showingLogo" value=true}
	{if !$displayPageHeaderLogo}
		{assign var="showingLogo" value=false}
	{/if}
{/strip}
<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
{if !$pageTitleTranslated}{capture assign="pageTitleTranslated"}{translate key=$pageTitle}{/capture}{/if}
{include file="frontend/components/headerHead.tpl"}
<body class="pkp_page_{$requestedPage|escape|default:"index"} pkp_op_{$requestedOp|escape|default:"index"}{if $showingLogo} has_site_logo{/if}" dir="{$currentLocaleLangDir|escape|default:"ltr"}">

	
	<!-- Header start -->
    <header>
        <!-- Top header start -->
        <div class="accent-bg text-white py-3">
            <div class="container mx-auto flex justify-between items-center">
                <!-- ISSN text start -->
                <div>
                    <p class="inline pr-6"><span class="font-bold">Online ISSN: </span>2345-4041</p>
                    <p class="inline"><span class="font-bold">Print ISSN: </span>2345-4041</p>
                </div>
                <!-- ISSN text end -->

                <!-- Auth menu name start -->
                <div>
					{load_menu name="user" ulClass="space-x-4" liClass="inline"}
                </div>
                <!-- Auth menu name end -->
            </div>
        </div>
        <!-- Top header end -->

        <!-- Second part of header start -->
        <div class="bg-white py-6 box-shadow">
            <div class="container mx-auto flex justify-between items-center">
                <!-- Logo/Journal name start -->
                <div class="text-3xl text-black font-bold">
					{capture assign="homeUrl"}
						{url page="index" router=$smarty.const.ROUTE_PAGE}
					{/capture}
					{if $displayPageHeaderLogo}
						<a href="{$homeUrl}" class="is_img">
							<img src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}" width="{$displayPageHeaderLogo.width|escape}" height="{$displayPageHeaderLogo.height|escape}" {if $displayPageHeaderLogo.altText != ''}alt="{$displayPageHeaderLogo.altText|escape}"{/if} />
						</a>
					{elseif $displayPageHeaderTitle}
						<h1><a class="hover:text-gray-800" href="{$homeUrl}">{$displayPageHeaderTitle|escape}</a></h1>
					{else}
						<h1><a class="hover:text-gray-800" href="{$homeUrl}">{$displayPageHeaderTitle|escape}</a></h1>
					{/if}
                </div>
                <!-- Logo/Journal name end -->

                <!-- Main menu name start -->
                <div>
					{load_menu name="primary" ulClass="space-x-4" liClass="inline"}
                </div>
                <!-- Main menu name end -->
            </div>
        </div>
        <!-- Second part of header end -->
    </header>
    <!-- Header end -->

    <!-- Main content start -->
	<div class="container mx-auto my-10">