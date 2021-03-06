<#ftl output_format="HTML">
<!DOCTYPE html>
<html lang="${config.thymeleaf_locale}">
  <head>
    <meta charset="${config.render_encoding}"/>
    <title><#if content.title??>${content.title}<#else>${config.site_title}</#if></title>

    <#if (content.title)??>
      <meta name="viewport" content="width=device-width, initial-scale=0.5">
    <#else>
      <!-- not scale -->
    </#if>

    <meta name="description" content="${config.site_description}">
    <meta name="author" content="${config.site_author}">

    <#if (content.tags)??>
    <#assign strtags>${content.tags?join(",")}</#assign>
    <meta name="tags" content="${strtags}">
    </#if>

    <#if (config.render_feed)??>
    <link href="${config.site_baseurl}${config.feed_file}" rel="alternate" type="application/rss+xml" title="Les derniers billets" />
    </#if>

    <meta name="generator" content="JBake">

    <#-- Le styles commun -->
    <link rel="stylesheet" href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>stylesheet.css">

    <#if (content.title)??>
      <#-- post and page CSS -->
      <meta property="og:url" content="${config.site_host}/${content.uri}" />
      <meta property="og:title" content="${content.title}" />

      <#if (content.summary)??>
        <meta name="twitter:card" content="${content.summary}" />
        <meta property="og:description" content="${content.summary}" />
      </#if>

    <link href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/styles/github.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/highlight.min.js"></script>
    <#else>
      <#-- we are in the index or archive-->
      <meta property="og:title" content="${config.site_title}" />

      <#if (config.site_description)??>
        <meta name="twitter:card" content="${config.site_description}" />
        <meta property="og:description" content="${config.site_description}" />
      </#if>

      <#-- index and archive CSS -->
      <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
      <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap-theme.min.css">
      <link rel="stylesheet" href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>home.css">
    </#if>

    <#if (config.share_twitter)??>
    <meta name="twitter:site" content="@${config.share_twitter}" />
    <meta name="twitter:creator" content="@${config.share_twitter}" />
    </#if>

    <link rel="manifest" href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>site.webmanifest"/>
    <link rel="shortcut icon" href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>favicon.ico" />
    <link rel="stylesheet" href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>main.css">
    <link rel="stylesheet" href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>css/line-awesome.min.css">

	<script>
	  const baseUrl = '${config.site_baseurl}';
	  const baseUrlIndex = '${config.site_baseurl}index.html';
    <#if (content.title)??>
      hljs.initHighlightingOnLoad();
    </#if>
	</script>
  </head>
