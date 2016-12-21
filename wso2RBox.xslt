<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	 xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	 xmlns:xs="http://www.w3.org/2001/XMLSchema"
	 xmlns:wso2="http://ws.apache.org/ns/synapse"
	 xmlns:fn="http://www.w3.org/2005/xpath-functions" 
	 xmlns:owl="http://www.w3.org/2002/07/owl#" 
	 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	 xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
	 xmlns:ta="http://www.bls.ch/soa/ontologies/wso2/2016/12/ABoxTA#"
	 xmlns:core-soa="http://www.semanticweb.org/ontologies/2010/01/core-soa.owl#"
	 >
	 
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" media-type="application/rdf+xml"/>
	<xsl:template match="/">

		<rdf:RDF
			xmlns="http://www.bls.ch/soa/ontologies/wso2/2016/12/RBoxTA#"
			xml:base="http://www.bls.ch/soa/ontologies/wso2/2016/12/RBoxTA#"
			xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
			xmlns:owl="http://www.w3.org/2002/07/owl#"
			xmlns:xml="http://www.w3.org/XML/1998/namespace"
			xmlns:wso2="http://ws.apache.org/ns/synapse"
			xmlns:fn="http://www.w3.org/2005/xpath-functions"
			xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
			xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
			xmlns:xs="http://www.w3.org/2001/XMLSchema"
			xmlns:dc="http://purl.org/dc/elements/1.1"
			xmlns:ta="http://www.bls.ch/soa/ontologies/wso2/2016/12/ABoxTA#"
			xmlns:core-soa="http://www.semanticweb.org/ontologies/2010/01/core-soa.owl#"
			>
	
			<xsl:text/>
			<xsl:comment> === Dublin Core Meta Data === </xsl:comment>
			<rdf:Description rdf:about="http://www.bls.ch/soa/ontologies/wso2/2016/12/ABoxTA">
				<dc:creator>Robert Wydler</dc:creator>
				<dc:title>WSO2 ABox</dc:title>
				<dc:description>This is the generated WSO2 RBox based on WSO2 ESB configuration of the Ticket Accounting Service</dc:description>
				<dc:date>2016-21</dc:date>
			</rdf:Description>
			
			<owl:Ontology rdf:about="http://www.bls.ch/soa/ontologies/wso2/2016/12/RBoxTA">
				<owl:imports rdf:resource="http://www.bls.ch/soa/ontologies/wso2/2016/12/ABoxTA"/>
			</owl:Ontology>

			<!-- Define new property "contains/containedBy" -->
			<xsl:text/>
			<xsl:comment> === Define new property "contains/containedBy" === </xsl:comment>
			<rdf:Description rdf:about="http://www.bls.ch/soa/ontologies/wso2/2016/12/RBox#contains">
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#ObjectProperty"/>
					<rdfs:subPropertyOf rdf:resource="http://www.semanticweb.org/ontologies/2010/01/core-soa.owl#uses"/>
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#TransitiveProperty"/>
			</rdf:Description>
			<rdf:Description rdf:about="http://www.bls.ch/soa/ontologies/wso2/2016/12/RBox#containedBy">
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#ObjectProperty"/>
					<rdfs:subPropertyOf rdf:resource="http://www.semanticweb.org/ontologies/2010/01/core-soa.owl#usedBy"/>
				<owl:inverseOf rdf:resource="http://www.bls.ch/soa/ontologies/wso2/2016/12/RBox#contains"/>
			</rdf:Description>

			<!-- Define new property "calls/calledBy" -->
			<xsl:text/>
			<xsl:comment> === Define new property "calls/calledBy" === </xsl:comment>
			<rdf:Description rdf:about="http://www.bls.ch/soa/ontologies/wso2/2016/12/RBox#calls">
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#ObjectProperty"/>
					<rdfs:subPropertyOf rdf:resource="http://www.semanticweb.org/ontologies/2010/01/core-soa.owl#uses"/>
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#TransitiveProperty"/>
			</rdf:Description>
			<rdf:Description rdf:about="http://www.bls.ch/soa/ontologies/wso2/2016/12/RBox#calledBy">
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#ObjectProperty"/>
					<rdfs:subPropertyOf rdf:resource="http://www.semanticweb.org/ontologies/2010/01/core-soa.owl#usedBy"/>
				<owl:inverseOf rdf:resource="http://www.bls.ch/soa/ontologies/wso2/2016/12/RBox#calls"/>
			</rdf:Description>

			<xsl:apply-templates/>

		</rdf:RDF>
	</xsl:template>
	
	<xsl:template match="//text()"/>

	<!-- Indivdual assertion  = f(type); only compositions are able to call templates (except 1st level)-->
	<xsl:template match="wso2:definitions">
		<xsl:text/>
		<xsl:comment> === First Level Dependency === </xsl:comment>
		<xsl:call-template name="selectType"/>
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template name="selectType">
		<xsl:for-each select="*">
			<xsl:call-template name="roleTemplate">
				<xsl:with-param name="argSource" select="@name"/>
				<xsl:with-param name="argTarget" select="@name"/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="roleTemplate">
		<xsl:param name="argSource"/>
		<xsl:param name="argTarget"/>

		<!-- Assert to call-template -->
		<xsl:comment> === Assert to call-template === </xsl:comment>
			<xsl:for-each select="$argTarget">
				<xsl:if test="fn:exists($argSource)">
					<!-- Assert individuals to properties -->
					<owl:NamedIndividual>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="fn:concat('http://www.bls.ch/soa/ontologies/wso2/2016/12/ABoxTA#',$argSource)"/>
						</xsl:attribute>
						<core-soa:uses>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="fn:concat('http://www.bls.ch/soa/ontologies/wso2/2016/12/ABoxTA#',$argTarget)"/>
							</xsl:attribute>
						</core-soa:uses>
					</owl:NamedIndividual>
				</xsl:if>
			</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
