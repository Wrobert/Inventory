<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:wso2="http://ws.apache.org/ns/synapse" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:esb="http://www.bls.ch/soa/ontologies/wso2/2016/12/ESB#">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<rdf:RDF xmlns="http://www.bls.ch/soa/ontologies/wso2/2016/12/ESB#" xml:base="http://www.bls.ch/soa/ontologies/wso2/2016/12/ESB#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:xml="http://www.w3.org/XML/1998/namespace" xmlns:wso2="http://ws.apache.org/ns/synapse" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:xsd="http://www.w3.org/2001/XMLSchema#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:xs="http://www.w3.org/2001/XMLSchema">
			<owl:Ontology rdf:about="http://www.bls.ch/soa/ontologies/wso2/2016/12/TBox">
				<owl:imports rdf:resource="http://www.semanticweb.org/ontologies/2010/01/core-soa.owl"/>
			</owl:Ontology>
			<xsl:comment> === Constant Super Classes === </xsl:comment>
			<owl:Class>
				<xsl:attribute name="rdf:about"><xsl:text>#Unknown</xsl:text></xsl:attribute>
			</owl:Class>
			<owl:Class>
				<xsl:attribute name="rdf:about"><xsl:text>#Component</xsl:text></xsl:attribute>
			</owl:Class>
			<owl:Class>
				<xsl:attribute name="rdf:about"><xsl:text>#Mediator</xsl:text></xsl:attribute>
				<rdfs:subClassOf>
					<xsl:attribute name="rdf:resource"><xsl:text>#Component</xsl:text></xsl:attribute>
				</rdfs:subClassOf>
			</owl:Class>
			<owl:Class rdf:about="#Component">
				<rdfs:subClassOf rdf:resource="http://www.semanticweb.org/ontologies/2010/01/core-soa.owl#Element"/>
				<owl:disjointWith rdf:resource="http://www.semanticweb.org/ontologies/2010/01/core-soa.owl#Composition"/>
			</owl:Class>
			<!-- xsl:comment> === Generated 1. Level Classes === </xsl:comment>
			<xsl:call-template name="classTemplate" / -->
			<xsl:apply-templates/>
		</rdf:RDF>
	</xsl:template>
	<!-- 1. level Classes -->
	<xsl:template match="wso2:definitions">
		<xsl:call-template name="classTemplate"/>
		<xsl:apply-templates/>
	</xsl:template>
	<!-- 2. level Classes -->
	<xsl:template match="wso2:definitions/*">
		<xsl:call-template name="classTemplate"/>
		<xsl:apply-templates/>
	</xsl:template>
	<!-- 3. level Classes -->
	<xsl:template match="wso2:definitions/*/*">
		<xsl:call-template name="classTemplate"/>
	</xsl:template>
	<xsl:template name="classTemplate">
		<!-- Prepare the super class name list -->
		<xsl:variable name="processList" select="'#SequenceClass, #TemplateClass, #OutSequenceClass, #FaultSequenceClass, #Call-templateClass'"/>
		<xsl:variable name="serviceCompositionList" select="'#ProxyClass'"/>
		<xsl:variable name="mediatorList" select="'#FilterClass, #CallClass, #SmooksClass, #DropClass, #ValidateClass, #LogClass, #PropertyClass, #XsltClass, #MessageStoreClass, #MessageProcessorClass, #InboundEndpointClass'"/>
		<xsl:for-each select="*">
			<!-- Filter multiple nodes; do not need the first one -->
			<xsl:variable name="position" select="fn:position()"/>
			<xsl:variable name="actualName" select="fn:local-name()"/>
			<xsl:variable name="nextName" select="../*[$position+1]/fn:local-name()"/>
			<!-- Prepare the new class name  -->
			<xsl:if test="fn:not($actualName=$nextName)">
				<xsl:variable name="rest" select="fn:substring ($nextName,2)"/>
				<xsl:variable name="letter" select="fn:upper-case(fn:substring($nextName,1,1))"/>
				<xsl:variable name="className" select="fn:concat('#',$letter,$rest,'Class')"/>
				<xsl:if test="fn:not($className = '#Class')">
					<!-- Generate TBox  -->
					<owl:Class>
						<xsl:attribute name="rdf:about"><xsl:value-of select="$className"/></xsl:attribute>
						<rdfs:subClassOf>
							<xsl:attribute name="rdf:resource"><xsl:choose><xsl:when test="
											fn:contains(
												fn:concat(', ', fn:normalize-space($processList), ', '), 
												fn:concat(', ', $className, ', ')) "><xsl:text>http://www.semanticweb.org/ontologies/2010/01/core-soa.owl#Process</xsl:text></xsl:when><xsl:when test="
											fn:contains(fn:concat(', ', fn:normalize-space($serviceCompositionList), ', '), 										fn:concat(', ', $className, ', ')) "><xsl:text>http://www.semanticweb.org/ontologies/2010/01/core-soa.owl#ServiceComposition</xsl:text></xsl:when><xsl:when test=" fn:contains(fn:concat(', ', fn:normalize-space($mediatorList), ', '),
											fn:concat(', ', $className, ', ')) "><xsl:text>#Mediator</xsl:text></xsl:when><xsl:otherwise><xsl:text>#Unknown</xsl:text></xsl:otherwise></xsl:choose></xsl:attribute>
						</rdfs:subClassOf>
					</owl:Class>
				</xsl:if>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
