<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:wso2="http://ws.apache.org/ns/synapse" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:esb="http://www.bls.ch/soa/ontologies/wso2/2016/12/ESB#">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" media-type="application/rdf+xml"/>
	<!-- Globale Variablen -->
	<!-- Keep class name  for distinction - NOT IMPLEMENTED YET-->
	<xsl:variable name="classList" select="'#Unknown'"/>

	<xsl:template match="/wso2:definitions">
		<rdf:RDF xmlns="http://www.bls.ch/soa/ontologies/wso2/2016/12/ESB#" xml:base="http://www.bls.ch/soa/ontologies/wso2/2016/12/ESB#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:xml="http://www.w3.org/XML/1998/namespace" xmlns:wso2="http://ws.apache.org/ns/synapse" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:xsd="http://www.w3.org/2001/XMLSchema#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:xs="http://www.w3.org/2001/XMLSchema">			<owl:Ontology rdf:about="http://www.bls.ch/soa/ontologies/wso2/2016/12/ABoxTicketAccounting">
				<owl:imports rdf:resource="http://www.bls.ch/soa/ontologies/wso2/2016/12/TBox"/>
			</owl:Ontology>
			<xsl:apply-templates />
		</rdf:RDF>
	</xsl:template>

	<!-- 1. level indivdual assertion  -->
	<xsl:template match="//text()" />
	<xsl:template match="*">
			<xsl:call-template name="selectType"/>
			<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="*/*">
			<xsl:call-template name="selectType"/>
			<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="*/*/*">
			<xsl:call-template name="selectType"/>
			<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="*/*/*/*">
			<xsl:call-template name="selectType"/>
			<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="*/*/*/*/*">
			<xsl:call-template name="selectType"/>
	</xsl:template>
	<xsl:template match="*/*/*/*/*/*">
			<xsl:call-template name="selectType"/>
	</xsl:template>
	
	<xsl:template name="selectType">
		<xsl:choose>
			<xsl:when test="fn:exists(@name)">
				<xsl:call-template name="individualTemplate">
					<xsl:with-param name="argType" select="@name"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="fn:exists(@description)">
				<xsl:call-template name="individualTemplate">
					<xsl:with-param name="argType" select="@description"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="fn:exists(@key)">
				<xsl:call-template name="individualTemplate">
					<xsl:with-param name="argType" select="@key"/>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="individualTemplate">
		<xsl:param name="argType"/>
		<!-- Prepare the new class name  -->
		<xsl:variable name="actualName" select="fn:local-name()"/>
		<xsl:variable name="letter" select="fn:upper-case(fn:substring($actualName,1,1))"/>
		<xsl:variable name="rest" select="fn:substring ($actualName,2)"/>
		<xsl:variable name="className" select="fn:concat('#',$letter,$rest,'Class')"/>
		<xsl:if test="fn:not($argType = ' ') and fn:exists($className)">
		<!-- Assert the indivuduals to classes  -->
					<owl:NamedIndividual>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="fn:concat('#',$argType)"/>
						</xsl:attribute>
					<rdf:type>
						<xsl:attribute name="rdf:resource">
							<xsl:value-of select="$className"/>
						</xsl:attribute>
					</rdf:type>
				</owl:NamedIndividual>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
