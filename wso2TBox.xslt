<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:wso2="http://ws.apache.org/ns/synapse" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:esb="http://www.bls.ch/soa/ontologies/wso2/2016/12/ESB#">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" media-type="application/rdf+xml"/>
	<!-- Globale Variablen -->
	<!-- Keep class name  for distinction - NOT IMPLEMENTED YET-->
	<xsl:variable name="classList" select="'#Unknown'"/>

	<xsl:template match="/">
		<rdf:RDF xmlns="http://www.bls.ch/soa/ontologies/wso2/2016/12/ESB#" xml:base="http://www.bls.ch/soa/ontologies/wso2/2016/12/ESB#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:xml="http://www.w3.org/XML/1998/namespace" xmlns:wso2="http://ws.apache.org/ns/synapse" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:xsd="http://www.w3.org/2001/XMLSchema#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:dc="http://purl.org/dc/elements/1.1">
		<xsl:text/>
		<xsl:comment> === Dublin Core Meta Data === </xsl:comment>
		<rdf:Description rdf:about="http://www.bls.ch/soa/ontologies/wso2/2016/12/TBox">
			<dc:creator>Robert Wydler</dc:creator>
			<dc:title>WSO2 TBox</dc:title>
			<dc:description>This is the generated WSO2 TBox based on WSO2 ESB configuration</dc:description>
			<dc:date>2016-12-16</dc:date>
		</rdf:Description>
			
			<owl:Ontology rdf:about="http://www.bls.ch/soa/ontologies/wso2/2016/12/TBox">
				<owl:imports rdf:resource="http://www.semanticweb.org/ontologies/2010/01/core-soa.owl"/>
			</owl:Ontology>
			<xsl:comment> === Constant Super Classes === </xsl:comment>
		<owl:Class rdf:about="#Unknown">
			<rdfs:label xml:lang="en">Unknown</rdfs:label>
		</owl:Class>
		<owl:Class rdf:about="#Component">
			<rdfs:label xml:lang="en">Component</rdfs:label>
		</owl:Class>
		<owl:Class rdf:about="#Mediator">
			<rdfs:label xml:lang="en">Mediator</rdfs:label>
			<rdfs:subClassOf rdf:resource="#Component"/>
		</owl:Class>
		<owl:Class rdf:about="#WSO2System">
			<rdfs:label xml:lang="en">WSO2System</rdfs:label>
			<rdfs:subClassOf rdf:resource="#Component"/>
		</owl:Class>
		<xsl:comment>  === Generated Classes === </xsl:comment>
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

	<!-- Template as XSLT Subroutine -->
	<xsl:template name="classTemplate">

		<!-- Prepare the super class name list -->
		<xsl:variable name="systemList" select="'#On-failClass, #InClass, #OutClass, #InputClass, #OutputClass, #SchemaClass, #ResourceClass, #PublishWSDLClass, #TargetClass, #TaskManagerClass, #ParameterClass, #RegistryClass, #DescriptionClass, #With-paramClass, #ParameterClass, #ParametersClass'"/>
		<xsl:variable name="processList" select="'#SequenceClass, #TemplateClass, #InSequenceClass, #OutSequenceClass, #FaultSequenceClass, #Call-templateClass'"/>
		<xsl:variable name="serviceCompositionList" select="'#ProxyClass'"/>
		
		<xsl:variable name="mediatorList" select="'#EndpointClass, #HeaderClass, #FilterClass, #CallClass, #SmooksClass, #DropClass, #SendClass, #ValidateClass, #LogClass, #PropertyClass, #XsltClass, #MessageStoreClass, #MessageProcessorClass, #InboundEndpointClass'"/>


		<xsl:for-each select="*">
			<xsl:variable name="actualName" select="fn:local-name()"/>
			<!-- Prepare the new class name  -->
			<xsl:variable name="rest" select="fn:substring ($actualName,2)"/>
			<xsl:variable name="letter" select="fn:upper-case(fn:substring($actualName,1,1))"/>
			<xsl:variable name="className" select="fn:concat('#',$letter,$rest,'Class')"/>
			<xsl:if test="fn:not($className = '#Class')">
				<!-- Check the class list for already known -->
	
					<!-- Generate TBox  -->
					<owl:Class>
						<xsl:attribute name="rdf:about"><xsl:value-of select="$className"/></xsl:attribute>
						<rdfs:label xml:lang="en">
							<xsl:value-of select="fn:substring($className,2)"/>
						</rdfs:label>
						<rdfs:subClassOf>
							<xsl:attribute name="rdf:resource">
								<xsl:choose>
									<xsl:when test="
											fn:contains(
												fn:concat(', ', fn:normalize-space($processList), ', '), 
												fn:concat(', ', $className, ', ')) ">
										<xsl:text>http://www.semanticweb.org/ontologies/2010/01/core-soa.owl#Process</xsl:text>
									</xsl:when>
									<xsl:when test="
											fn:contains(fn:concat(', ', fn:normalize-space($serviceCompositionList), ', '), fn:concat(', ', $className, ', ')) ">
										<xsl:text>http://www.semanticweb.org/ontologies/2010/01/core-soa.owl#ServiceComposition</xsl:text>
									</xsl:when>
									<xsl:when test=" fn:contains(fn:concat(', ', fn:normalize-space($mediatorList), ', '), fn:concat(', ', $className, ', ')) ">
										<xsl:text>#Mediator</xsl:text>
									</xsl:when>
									<xsl:when test=" fn:contains(fn:concat(', ', fn:normalize-space($systemList), ', '), fn:concat(', ', $className, ', ')) ">
										<xsl:text>#WSO2System</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>#Unknown</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
						</rdfs:subClassOf>
					</owl:Class>

			</xsl:if>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
