<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- RNDT SCHEMATRON-->
	<sch:title xmlns="http://www.w3.org/2001/XMLSchema">Schematron validation for ISO
		19115(19139) RNDT Profile</sch:title>
	<sch:ns prefix="gml" uri="http://www.opengis.net/gml"/>
	<sch:ns prefix="gmd" uri="http://www.isotc211.org/2005/gmd"/>
	<sch:ns prefix="srv" uri="http://www.isotc211.org/2005/srv"/>
	<sch:ns prefix="gco" uri="http://www.isotc211.org/2005/gco"/>
	<sch:ns prefix="geonet" uri="http://www.fao.org/geonetwork"/>
	<sch:ns prefix="xlink" uri="http://www.w3.org/1999/xlink"/>
	<!--FILE IDENTIFIER-->
	<sch:pattern>
		<sch:title>$loc/strings/M1</sch:title>
		<sch:rule context="//gmd:MD_Metadata">
			<sch:assert test="gmd:fileIdentifier/gco:CharacterString">$loc/strings/alert.M1</sch:assert>
		</sch:rule>
	</sch:pattern>
	<!--METADATA LANGUAGE-->
	<sch:pattern>
		<sch:title>$loc/strings/M2</sch:title>
		<sch:rule context="//gmd:MD_Metadata">
			<sch:assert test="gmd:language/gmd:LanguageCode">$loc/strings/alert.M2</sch:assert>
		</sch:rule>
	</sch:pattern>
	<!--PARENT IDENTIFIER-->
	<sch:pattern>
		<sch:title>$loc/strings/M3</sch:title>
		<sch:rule context="//gmd:MD_Metadata">
			<sch:assert test="gmd:parentIdentifier/gco:CharacterString">$loc/strings/alert.M3</sch:assert>
		</sch:rule>
	</sch:pattern>
	<!--HIERARCHY LEVEL-->
	<sch:pattern>
		<sch:title>$loc/strings/M4</sch:title>
		<sch:rule context="//gmd:MD_Metadata">
			<sch:assert test="gmd:hierarchyLevel/gmd:MD_ScopeCode">$loc/strings/alert.M4</sch:assert>
		</sch:rule>
	</sch:pattern>
	<!--METADATA STANDARD NAME-->
	<sch:pattern>
		<sch:title>$loc/strings/M5</sch:title>
		<sch:rule context="//gmd:MD_Metadata">
			<sch:assert test="gmd:metadataStandardName/gco:CharacterString and contains(gmd:metadataStandardName/gco:CharacterString,'DM - Regole tecniche RNDT')">$loc/strings/alert.M5</sch:assert>
			<!--	<sch:assert test="gmd:metadataStandardName/gco:CharacterString and  gmd:metadataStandardName/gco:CharacterString/@value='DM - Regole tecniche RNDT'">$loc/strings/alert.M5</sch:assert>-->
		</sch:rule>
	</sch:pattern>
	<!--METADATA STANDARD VERSION-->
	<sch:pattern>
		<sch:title>$loc/strings/M6</sch:title>
		<sch:rule context="//gmd:MD_Metadata">
			<sch:assert test="gmd:metadataStandardVersion/gco:CharacterString and gmd:metadataStandardVersion/gco:CharacterString/@value = '10 novembre 2011'">$loc/strings/alert.M6</sch:assert>
		</sch:rule>
	</sch:pattern>
	<!--METADATA CHARACTER SET-->
	<sch:pattern>
		<sch:title>$loc/strings/M7</sch:title>
		<sch:rule context="//gmd:MD_Metadata">
			<sch:assert test="gmd:characterSet/gmd:MD_CharacterSetCode">$loc/strings/alert.M7</sch:assert>
		</sch:rule>
	</sch:pattern>
	<!--DATA IDENTIFICATION - DATE TYPE-->
	<sch:pattern>
		<sch:title>$loc/strings/M8</sch:title>
		<sch:rule context="//gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation">
			<sch:assert test="gmd:date/gmd:CI_Date/gmd:dateType/gmd:CI_DateTypeCode">$loc/strings/alert.M8</sch:assert>
		</sch:rule>
	</sch:pattern>
	<!--DATA IDENTIFICATION - RESPONSIBLE PARTY-->
	<sch:pattern>
		<sch:title>$loc/strings/M9</sch:title>
		<sch:rule context="//gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation">
			<sch:let name="responsibleParty" value="(gmd:citedResponsibleParty/gmd:CI_ResponsibleParty/gmd:organisationName/gco:CharacterString) and (gmd:citedResponsibleParty/gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode) and (gmd:citedResponsibleParty/gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString) and ((gmd:citedResponsibleParty/gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:phone/gmd:CI_Telephone/gmd:voice/gco:CharacterString) or (gmd:citedResponsibleParty/gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/gmd:URL))"/>
			<sch:assert test="$responsibleParty">$loc/strings/alert.M9</sch:assert>
		</sch:rule>
	</sch:pattern>
	<!--DATA IDENTIFICATION - IDENTIFIER-->
	<sch:pattern>
		<sch:title>$loc/strings/M13</sch:title>
		<sch:rule context="//gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation">
			<sch:assert test="gmd:identifier/gmd:RS_Identifier/gmd:code/gco:CharacterString">$loc/strings/alert.M13</sch:assert>
		</sch:rule>
	</sch:pattern>
	<!--DATA IDENTIFICATION - SERIES-->
	<sch:pattern>
		<sch:title>$loc/strings/M14</sch:title>
		<sch:rule context="//gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation">
			<sch:assert test="gmd:series/gmd:CI_Series/gmd:issueIdentification/gco:CharacterString">$loc/strings/alert.M14</sch:assert>
		</sch:rule>
	</sch:pattern>
	<!--DATA IDENTIFICATION - KEYWORDS-->
	<!--DATA IDENTIFICATION - DATASET RESPONSIBLE PARTY-->
	/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact/gmd:CI_ResponsibleParty/gmd:organisationName/gco:CharacterString
	<sch:pattern>
		<sch:title>$loc/strings/M15</sch:title>
		<sch:rule context="//gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation">
			<sch:let name="responsibleParty" value="(gmd:citedResponsibleParty/gmd:CI_ResponsibleParty/gmd:organisationName/gco:CharacterString) and (gmd:citedResponsibleParty/gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode) and (gmd:citedResponsibleParty/gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString) and ((gmd:citedResponsibleParty/gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:phone/gmd:CI_Telephone/gmd:voice/gco:CharacterString) or (gmd:citedResponsibleParty/gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/gmd:URL))"/>
			<sch:assert test="$responsibleParty">$loc/strings/alert.M15</sch:assert>
		</sch:rule>
	</sch:pattern>
	<!--DATA IDENTIFICATION - PRESENTATION FORM-->
	<sch:pattern>
		<sch:title>$loc/strings/M30</sch:title>
		<sch:rule context="//gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation">
			<sch:assert test="gmd:presentationForm/gmd:CI_PresentationFormCode">$loc/strings/alert.M30</sch:assert>
		</sch:rule>
	</sch:pattern>
	<!--DATE FORMAT-->
	<!--
	<sch:pattern>
		<sch:title>$loc/strings/M100</sch:title>
		<sch:rule context="*[gco:Date]">
			<sch:assert test="matches(gco:Date,'^[0-9]{4}-(((0[13578]|(10|12))-(0[1-9]|[1-2][0-9]|3[0-1]))|(02-(0[1-9]|[1-2][0-9]))|((0[469]|11)-(0[1-9]|[1-2][0-9]|30)))$' )">$loc/strings/alert.M100</sch:assert>
		</sch:rule>
	</sch:pattern>-->
</sch:schema>
