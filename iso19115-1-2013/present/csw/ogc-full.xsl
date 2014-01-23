<?xml version="1.0" encoding="UTF-8"?>

<!-- FIXME: Not done yet .... -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
										xmlns:csw="http://www.opengis.net/cat/csw/2.0.2"
										xmlns:dc ="http://purl.org/dc/elements/1.1/"
										xmlns:dct="http://purl.org/dc/terms/"
										xmlns:gco="http://www.isotc211.org/2005/gco"
                    xmlns:cit="http://www.isotc211.org/2005/cit/1.0/2013-03-28" 
                    xmlns:mrl="http://www.isotc211.org/2005/mrl/1.0/2013-03-28"
                    xmlns:lan="http://www.isotc211.org/2005/lan/1.0/2013-03-28" 
                    xmlns:mcc="http://www.isotc211.org/2005/mcc/1.0/2013-03-28" 
                    xmlns:mrc="http://www.isotc211.org/2005/mrc/1.0/2013-03-28" 
                    xmlns:mco="http://www.isotc211.org/2005/mco/1.0/2013-03-28" 
                    xmlns:mds="http://www.isotc211.org/2005/mds/1.0/2013-03-28" 
                    xmlns:mri="http://www.isotc211.org/2005/mri/1.0/2013-03-28"
                    xmlns:mrs="http://www.isotc211.org/2005/mrs/1.0/2013-03-28"
                    xmlns:mrd="http://www.isotc211.org/2005/mrd/1.0/2013-03-28"
                    xmlns:gml="http://www.opengis.net/gml/3.2"
                    xmlns:srv="http://www.isotc211.org/2005/srv/2.0/2013-03-28"
                    xmlns:gcx="http://www.isotc211.org/2005/gcx/1.0/2013-03-28"
                    xmlns:gex="http://www.isotc211.org/2005/gex/1.0/2013-03-28"
										xmlns:geonet="http://www.fao.org/geonetwork"
										xmlns:ows="http://www.opengis.net/ows"
										exclude-result-prefixes="mds srv cit mrl lan mcc mrc mco mri mrs mrd gcx gex gco">

	<xsl:param name="displayInfo"/>
	<xsl:param name="lang"/>
	
	<xsl:include href="../metadata-utils.xsl"/>
	
	<!-- ============================================================================= -->

	<xsl:template match="mds:MD_Metadata|*[contains(@gco:isoType,'MD_Metadata')]">
		
		<xsl:variable name="info" select="geonet:info"/>
		<xsl:variable name="langId">
			<xsl:call-template name="getLangId19115-1-2013">
				<xsl:with-param name="langGui" select="$lang"/>
				<xsl:with-param name="md" select="."/>
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:variable name="identification" select="mds:identificationInfo/mri:MD_DataIdentification|
			mds:identificationInfo/*[contains(@gco:isoType, 'MD_DataIdentification')]|
			mds:identificationInfo/srv:SV_ServiceIdentification|
			mds:identificationInfo/*[contains(@gco:isoType, 'SV_ServiceIdentification')]"/>
		
		<csw:Record>

			<xsl:for-each select="mds:metadataIdentifier/mcc:MD_Identifier[mcc:codeSpace/*='urn:uuid']/mcc:code">
				<dc:identifier><xsl:value-of select="gco:CharacterString"/></dc:identifier>
			</xsl:for-each>

			<xsl:for-each select="mds:dateInfo/cit:date/cit:CI_Date[cit:dateType/cit:CI_DateTypeCode/@codeListValue='revision']/cit:date">
				<dc:date><xsl:value-of select="gco:Date|gco:DateTime"/></dc:date>
			</xsl:for-each>

			<!-- DataIdentification - - - - - - - - - - - - - - - - - - - - - -->

			<xsl:for-each select="$identification/mri:citation/cit:CI_Citation">	
				<xsl:for-each select="cit:title">
					<dc:title>
						<xsl:apply-templates mode="localised19115-1-2013" select=".">
								<xsl:with-param name="langId" select="$langId"/>
						</xsl:apply-templates>
					</dc:title>
				</xsl:for-each>
				
				<!-- Type - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
				
				<xsl:for-each select="../../../../mds:metadataScope/mds:MD_MetadataScope/mds:resourceScope/mcc:MD_ScopeCode/@codeListValue">
					<dc:type>
						<xsl:apply-templates mode="localised19115-1-2013" select=".">
								<xsl:with-param name="langId" select="$langId"/>
						</xsl:apply-templates>
					</dc:type>
				</xsl:for-each>
				
				<!-- subject -->
				
				<xsl:for-each select="../../mri:descriptiveKeywords/mri:MD_Keywords/mri:keyword[not(@gco:nilReason)]">
					<dc:subject>
						<xsl:apply-templates mode="localised19115-1-2013" select=".">
								<xsl:with-param name="langId" select="$langId"/>
						</xsl:apply-templates>
					</dc:subject>
				</xsl:for-each>

				<xsl:for-each select="../../mri:topicCategory/mri:MD_TopicCategoryCode">
					<dc:subject><xsl:value-of select="."/></dc:subject><!-- TODO : translate ? -->
				</xsl:for-each>
				
				
				<!-- Distribution - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
				
				<xsl:for-each select="../../../../mds:distributionInfo/mrd:MD_Distribution">
					<xsl:for-each select="mrd:distributionFormat/mrd:MD_Format/mrd:name">
						<dc:format>
							<xsl:apply-templates mode="localised19115-1-2013" select=".">
								<xsl:with-param name="langId" select="$langId"/>
							</xsl:apply-templates>
						</dc:format>
					</xsl:for-each>
				</xsl:for-each>
				
			
        <!-- FIXME: this is the date that the resource was modified - how does
                    this relate to the date that the metadata was modified -
                    see the dc:date above -->
				<xsl:for-each select="cit:date/cit:CI_Date[cit:dateType/cit:CI_DateTypeCode/@codeListValue='revision']/cit:date/gco:Date">
					<dct:modified><xsl:value-of select="."/></dct:modified>
				</xsl:for-each>

				<xsl:for-each select="cit:citedResponsibleParty/cit:CI_Responsibility[cit:role/cit:CI_RoleCode/@codeListValue='originator']/cit:party/cit:CI_Organisation/cit:name">
					<dc:creator>
						<xsl:apply-templates mode="localised19115-1-2013" select=".">
							<xsl:with-param name="langId" select="$langId"/>
						</xsl:apply-templates>
					</dc:creator>
				</xsl:for-each>

				<xsl:for-each select="cit:citedResponsibleParty/cit:CI_Responsibility[cit:role/cit:CI_RoleCode/@codeListValue='publisher']/cit:party/cit:CI_Organisation/cit:name">
					<dc:publisher>
						<xsl:apply-templates mode="localised19115-1-2013" select=".">
							<xsl:with-param name="langId" select="$langId"/>
						</xsl:apply-templates>
					</dc:publisher>
				</xsl:for-each>

				<xsl:for-each select="cit:citedResponsibleParty/cit:CI_Responsibility[cit:role/cit:CI_RoleCode/@codeListValue='author']/cit:party/cit:CI_Organisation/cit:name">
					<dc:contributor>
						<xsl:apply-templates mode="localised19115-1-2013" select=".">
							<xsl:with-param name="langId" select="$langId"/>
						</xsl:apply-templates>					
					</dc:contributor>
				</xsl:for-each>
			</xsl:for-each>

			
			<!-- abstract -->

			<xsl:for-each select="$identification/mri:abstract">
				<dct:abstract>
					<xsl:apply-templates mode="localised19115-1-2013" select=".">
						<xsl:with-param name="langId" select="$langId"/>
					</xsl:apply-templates>				
				</dct:abstract>
				<dc:description>
					<xsl:apply-templates mode="localised19115-1-2013" select=".">
						<xsl:with-param name="langId" select="$langId"/>
					</xsl:apply-templates>
				</dc:description>
			</xsl:for-each>

			<!-- rights -->

			<xsl:for-each select="$identification/mri:resourceConstraints/mco:MD_LegalConstraints|
				mri:resourceConstraints/*[@gco:isoType='mri:MD_LegalConstraints']">
				<xsl:for-each select="*/mri:MD_RestrictionCode/@codeListValue">
					<dc:rights><xsl:value-of select="."/></dc:rights>
				</xsl:for-each>

				<xsl:for-each select="mri:otherConstraints">
					<dc:rights>
						<xsl:apply-templates mode="localised19115-1-2013" select=".">
							<xsl:with-param name="langId" select="$langId"/>
						</xsl:apply-templates>									
					</dc:rights>
				</xsl:for-each>
			</xsl:for-each>

			<!-- language -->

			<xsl:for-each select="$identification/mri:defaultLocale/lan:PT_Locale/lan:language/lan:LanguageCode/@codeListValue">
				<dc:language><xsl:value-of select="."/></dc:language>
			</xsl:for-each>
			
			<!-- Lineage -->
			
			<xsl:for-each select="mds:resourceLineage/mrl:LI_Lineage/mrl:statement">
				<dc:source>
					<xsl:apply-templates mode="localised19115-1-2013" select=".">
						<xsl:with-param name="langId" select="$langId"/>
					</xsl:apply-templates>				
				</dc:source>
			</xsl:for-each>
			
			<!-- Parent Identifier -->
			
			<xsl:for-each select="mds:parentMetadata/mcc:MD_Identifier/mcc:code/gco:CharacterString">
				<dc:relation><xsl:value-of select="."/></dc:relation>
			</xsl:for-each>


			<!-- Distribution - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
			
			<xsl:for-each select="mds:distributionInfo/mrd:MD_Distribution">
				<xsl:for-each select="mrd:distributionFormat/mrd:MD_Format/mrd:name">
					<dc:format>
						<xsl:apply-templates mode="localised19115-1-2013" select=".">
							<xsl:with-param name="langId" select="$langId"/>
						</xsl:apply-templates>
					</dc:format>
				</xsl:for-each>
			</xsl:for-each>				

			<!-- bounding box -->

			<xsl:for-each select="$identification/mri:extent/gex:EX_Extent/gex:geographicElement/gex:EX_GeographicBoundingBox">
				<xsl:variable name="rsi"  select="/mds:MD_Metadata/mds:referenceSystemInfo/*/mrs:referenceSystemIdentifier/mcc:MD_Identifier"/>
				<xsl:variable name="auth" select="$rsi/mcc:codeSpace/gco:CharacterString"/>
				<xsl:variable name="id"   select="$rsi/mcc:code/gco:CharacterString"/>
				<xsl:variable name="crs" select="concat('urn:ogc:def:crs:', $auth, '::', $id)"/>

				<ows:BoundingBox>
					<xsl:attribute name="crs">
						<xsl:choose>
							<xsl:when test="$crs = 'urn:ogc:def:crs:::'">urn:ogc:def:crs:EPSG:6.6:4326</xsl:when>
							<xsl:otherwise><xsl:value-of select="$crs"/></xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					
					<ows:LowerCorner>
						<xsl:value-of select="concat(gex:eastBoundLongitude/gco:Decimal, ' ', gex:southBoundLatitude/gco:Decimal)"/>
					</ows:LowerCorner>
	
					<ows:UpperCorner>
						<xsl:value-of select="concat(gex:westBoundLongitude/gco:Decimal, ' ', gex:northBoundLatitude/gco:Decimal)"/>
					</ows:UpperCorner>
				</ows:BoundingBox>
			</xsl:for-each>


			<!-- Create as many URI element 
				* thumbnails
				* dataset online source elements
				* as coupledResource defined for a WMS service. 
				 * Get one connect point for the service
				 * Add as many layers defined in coupled resource elements.

				With this information, client could access to onlinesource defined in the metadata.
				
				CSW 2.0.2 ISO profil does not support dc:URI elements.
				What could be done is to add an output format supporting dclite4g 
				http://wiki.osgeo.org/wiki/DCLite4G (TODO)
				-->
			<xsl:for-each select="
				mds:identificationInfo/srv:SV_ServiceIdentification[srv:serviceType/gco:LocalName='OGC:WMS']|
				mds:identificationInfo/*[contains(@gco:isoType, 'SV_ServiceIdentification') and srv:serviceType/gco:LocalName='OGC:WMS'] ">
				
				<xsl:variable name="connectPoint" select="srv:containsOperations/srv:SV_OperationMetadata/srv:connectPoint/cit:CI_OnlineResource/cit:linkage/*"/>
				<xsl:variable name="serviceUrl">
					<xsl:choose>
						<xsl:when test="$connectPoint=''">
							<xsl:value-of select="../mds:distributionInfo/mrd:MD_Distribution/mrd:transferOptions/mrd:MD_DigitalTransferOptions/mrd:onLine/cit:CI_OnlineResource/cit:linkage/*"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$connectPoint"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				
				<dc:URI protocol="OGC:WMS-1.1.1-http-get-capabilities"><xsl:value-of select="$serviceUrl"/></dc:URI>
				<xsl:for-each select="srv:coupledResource/srv:SV_CoupledResource">
					<xsl:if test="gco:ScopedName!=''">
						<dc:URI protocol="OGC:WMS" name="{gco:ScopedName}"><xsl:value-of select="$serviceUrl"/></dc:URI>
					</xsl:if>
				</xsl:for-each>
				 
			</xsl:for-each>
			
			
			<xsl:for-each select="mds:distributionInfo/mrd:MD_Distribution">
				<xsl:for-each select="mrd:transferOptions/mrd:MD_DigitalTransferOptions/mrd:onLine/cit:CI_OnlineResource">
					<xsl:if test="cit:linkage">
						<dc:URI>
							<xsl:if test="cit:protocol">
								<xsl:attribute name="protocol"><xsl:value-of select="cit:protocol/gco:CharacterString"/></xsl:attribute>
							</xsl:if>
							
							<xsl:if test="cit:name">
								<xsl:attribute name="name">
									<xsl:for-each select="cit:name">
										<xsl:apply-templates mode="localised19115-1-2013" select=".">
											<xsl:with-param name="langId" select="$langId"/>
										</xsl:apply-templates>
									</xsl:for-each>
								</xsl:attribute>
							</xsl:if>
							
							<xsl:if test="cit:description">
								<xsl:attribute name="description">
									<xsl:for-each select="cit:description">
										<xsl:apply-templates mode="localised19115-1-2013" select=".">
											<xsl:with-param name="langId" select="$langId"/>
										</xsl:apply-templates>
									</xsl:for-each>
								</xsl:attribute>
							</xsl:if>
							
							<xsl:value-of select="cit:linkage/*"/>
						</dc:URI>
					</xsl:if>
				</xsl:for-each>
			</xsl:for-each>

			<xsl:for-each select="mds:identificationInfo/mri:MD_DataIdentification/mri:graphicOverview/mcc:MD_BrowseGraphic">
				<xsl:variable name="fileName" select="mcc:fileName/gco:CharacterString"/>
				<xsl:variable name="fileDescr" select="mcc:fileDescription/gco:CharacterString"/>
				
				<xsl:if test="$fileName!=''">
					<dc:URI>
						<xsl:choose>
							<xsl:when test="contains(mcc:fileName/gco:CharacterString, '.gif')">
								<xsl:attribute name="protocol">image/gif</xsl:attribute>
							</xsl:when>
							<xsl:when test="contains(mcc:fileName/gco:CharacterString, '.png')">
								<xsl:attribute name="protocol">image/png</xsl:attribute>
							</xsl:when>
						</xsl:choose>
						
						<xsl:if test="$fileDescr">
							<xsl:attribute name="name"><xsl:value-of select="$fileDescr"/></xsl:attribute>
						</xsl:if>
						<xsl:choose>
							<xsl:when test="contains($fileName ,'://')"><xsl:value-of select="$fileName"/></xsl:when>
							<xsl:otherwise><xsl:value-of select="concat('resources.get?id=',$info/id,'&amp;fname=',$fileName,'&amp;access=public')"/>
							</xsl:otherwise>
						</xsl:choose>
						
					</dc:URI>
				</xsl:if>
			</xsl:for-each>
			
			<!-- GeoNetwork elements added when resultType is equal to results_with_summary -->
			<xsl:if test="$displayInfo = 'true'">
				<xsl:copy-of select="$info"/>
            </xsl:if>
			
		</csw:Record>
	</xsl:template>

	<!-- ============================================================================= -->

	<xsl:template match="*">
		<xsl:apply-templates select="*"/>
	</xsl:template>

	<!-- ============================================================================= -->

</xsl:stylesheet>
