﻿<cfif thisTag.executionMode is "end"><cfsetting enablecfoutputonly="false">
<cfsilent>
<cfparam name="attributes.autoResizeEnabled" default="false" />
<cfparam name="attributes.facebookApp" />
<cfparam name="attributes.cookieEnabled" default="true" />
<cfparam name="attributes.localeCode" default="en_US" />
<cfparam name="attributes.statusEnabled" default="false" />
<cfparam name="attributes.xfbmlEnabled" default="true" />
<cfset userSession = attributes.facebookApp.getUserSession() />
</cfsilent>
<cfoutput>
	<div id="fb-root"></div>
	<script type="text/javascript">
		window.fbAsyncInit = function() {
			FB.init({
				appId   : "#attributes.facebookApp.getAppId()#",
				<cfif structKeyExists(userSession, "uid") and userSession.uid is not "">session : #serializeJson(userSession)#,</cfif> // don't refetch the session when Server already has it
				status  : <cfif attributes.statusEnabled>true<cfelse>false</cfif>, // check login status
				cookie  : <cfif attributes.cookieEnabled>true<cfelse>false</cfif>, // enable cookies to allow the server to access the session
				xfbml   : <cfif attributes.xfbmlEnabled>true<cfelse>false</cfif> // parse XFBML
			});
			
			<cfif attributes.autoResizeEnabled>
				FB.Canvas.setAutoResize();
			<cfelse>
				FB.Canvas.setSize();
			</cfif>
			
			#thisTag.generatedContent#
		};
	
		(function() {
			var e = document.createElement("script");
			e.src = document.location.protocol + "//connect.facebook.net/#attributes.localeCode#/all.js";
			e.async = true;
			document.getElementById("fb-root").appendChild(e);
		}());
	</script>
	<cfset thisTag.generatedContent = "" />
</cfoutput>
</cfif>