<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	 xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	 xmlns:xs="http://www.w3.org/2001/XMLSchema"
	 xmlns:wso2="http://ws.apache.org/ns/synapse"
	 xmlns:fn="http://www.w3.org/2005/xpath-functions" 
	 xmlns:owl="http://www.w3.org/2002/07/owl#" 
	 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	 xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
	 xmlns:tb="http://www.bls.ch/soa/ontologies/wso2/2016/12/TBoxTA#"
	 >
	 
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" media-type="application/rdf+xml"/>
	<xsl:template match="/">

		<rdf:RDF
			xmlns="http://www.bls.ch/soa/ontologies/wso2/2016/12/ABoxTA#"
			xml:base="http://www.bls.ch/soa/ontologies/wso2/2016/12/ABoxTA#"
			xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
			xmlns:owl="http://www.w3.org/2002/07/owl#"
			xmlns:xml="http://www.w3.org/XML/1998/namespace"
			xmlns:wso2="http://ws.apache.org/ns/synapse"
			xmlns:fn="http://www.w3.org/2005/xpath-functions"
			xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
			xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
			xmlns:xs="http://www.w3.org/2001/XMLSchema"
			xmlns:dc="http://purl.org/dc/elements/1.1"
			xmlns:tb="http://www.bls.ch/soa/ontologies/wso2/2016/12/TBoxTA#"
			>
	
			<xsl:text/>
			<xsl:comment> === Dublin Core Meta Data === </xsl:comment>
			<rdf:Description rdf:about="http://www.bls.ch/soa/ontologies/wso2/2016/12/ABoxTA">
				<dc:creator>Robert Wydler</dc:creator>
				<dc:title>WSO2 ABox</dc:title>
				<dc:description>This is the generated WSO2 ABox based on WSO2 ESB configuration of the Ticket Accounting Service</dc:description>
				<dc:date>2016-20</dc:date>
			</rdf:Description>
			
			<owl:Ontology rdf:about="http://www.bls.ch/soa/ontologies/wso2/2016/12/ABoxTA">
				<owl:imports rdf:resource="http://www.bls.ch/soa/ontologies/wso2/2016/12/TBoxTA"/>
			</owl:Ontology>
			<xsl:apply-templates/>
		</rdf:RDF>
	</xsl:template>


	<xsl:template match="//text()"/>

	<!-- Indivdual assertion  = f(type); only compositions are able to call templates (except 1st level)-->
	<xsl:template match="wso2:definitions">
		<xsl:call-template name="selectType"/>
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="wso2:definitions/wso2:sequence">
		<xsl:call-template name="selectType"/>
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="wso2:definitions/wso2:template/wso2:sequence">
		<xsl:call-template name="selectType"/>
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="wso2:definitions/wso2:proxy/wso2:target/wso2:inSequence">
		<xsl:call-template name="selectType"/>
		<xsl:apply-templates/>
	</xsl:template>
	
	
	<xsl:template name="selectType">
				<xsl:text/>
				<xsl:comment> === Assertion Individuals === </xsl:comment>
				<xsl:for-each select="*">
						<xsl:call-template name="individualTemplate">
							<xsl:with-param name="argType" select="@name"/>
						</xsl:call-template>
						<xsl:call-template name="individualTemplate">
							<xsl:with-param name="argType" select="@provider"/>
						</xsl:call-template>
						<xsl:call-template name="individualTemplate">
							<xsl:with-param name="argType" select="@description"/>
						</xsl:call-template>
						<xsl:call-template name="individualTemplate">
							<xsl:with-param name="argType" select="@config-key"/>
						</xsl:call-template>
						<xsl:call-template name="individualTemplate">
							<xsl:with-param name="argType" select="@key"/>
						</xsl:call-template>
				</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="individualTemplate">
		<xsl:param name="argType"/>
		<!-- Prepare the new class name  -->
		<xsl:variable name="actualName" select="fn:local-name()"/>
		<xsl:variable name="letter" select="fn:upper-case(fn:substring($actualName,1,1))"/>
		<xsl:variable name="rest" select="fn:substring ($actualName,2)"/>
		<xsl:variable name="className" select="fn:concat('#',$letter,$rest,'Class')"/>
		<xsl:if test="fn:string-length($argType) > 0" >
			<!-- Assert the indivuduals to classes  -->
			<owl:NamedIndividual>
				<xsl:attribute name="rdf:about"><xsl:value-of select="fn:concat('#',$argType)"/></xsl:attribute>
				<rdfs:label xml:lang="en">
					<xsl:value-of select="$argType" />
				</rdfs:label>
				<rdf:type>
					<xsl:attribute name="rdf:resource"><xsl:value-of select="fn:concat('http://www.bls.ch/soa/ontologies/wso2/2016/12/TBoxTA',$className)"/></xsl:attribute>
				</rdf:type>
			</owl:NamedIndividual>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
