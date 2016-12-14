<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:wso2="http://ws.apache.org/ns/synapse"
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		xmlns:owl="http://www.w3.org/2002/07/owl#"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
		xmlns:core-soa="http://www.semanticweb.org/ontologies/2010/01/core-soa.owl#"
		xmlns:tbox="http://www.bls.ch/soa/ontologies/wso2/2016/12/ESB#"
		>
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" media-type="application/rdf+xml"/>
	<xsl:template match="/wso2:definitions">
		<rdf:RDF xmlns="http://www.bls.ch/soa/ontologies/wso2/2016/12/ESB#"
			xml:base="http://www.bls.ch/soa/ontologies/wso2/2016/12/ESB#"
			xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
			xmlns:owl="http://www.w3.org/2002/07/owl#"
			xmlns:xml="http://www.w3.org/XML/1998/namespace"
			xmlns:wso2="http://ws.apache.org/ns/synapse"
			xmlns:fn="http://www.w3.org/2005/xpath-functions"
			xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
			xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
			xmlns:xs="http://www.w3.org/2001/XMLSchema">
			<owl:Ontology rdf:about="http://www.bls.ch/soa/ontologies/wso2/2016/12/ABoxTicketAccounting">
				<owl:imports rdf:resource="http://www.bls.ch/soa/ontologies/wso2/2016/12/TBox"/>
			</owl:Ontology>

			<xsl:apply-templates/>

			<!-- Set individuals as distinct -->
			<xsl:comment> === Set individuals as distinct === </xsl:comment>
			<rdf:Description>
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#AllDifferent"/>
				<owl:distinctMembers rdf:parseType="#Collection">
					<xsl:for-each select="*">
						<xsl:if test="fn:exists(@name)">
							<rdf:Description>
								<xsl:attribute name="rdf:about">
									<xsl:value-of select="fn:concat('#',@name)"/></xsl:attribute>
							</rdf:Description>
						</xsl:if>
					</xsl:for-each>
				</owl:distinctMembers>
			</rdf:Description>
		</rdf:RDF>
	</xsl:template>

	<!-- Assert individuals -->
	<xsl:template match="*">
		<!-- Prepare the new class name  -->
		<xsl:variable name="actualName" select="fn:local-name()"/>
		<xsl:variable name="letter" select="fn:upper-case(fn:substring($actualName,1,1))"/>
		<xsl:variable name="rest" select="fn:substring ($actualName,2)"/>
		<xsl:variable name="className" select="fn:concat('#',$letter,$rest,'Class')"/>
		<xsl:if test="fn:not($className = 'Class')">
			<!-- Assert the indivuduals to classes  -->
			<xsl:if test="fn:exists(@name)">
				<owl:NamedIndividual>
					<xsl:attribute name="rdf:about">
						<xsl:value-of select="fn:concat('#',@name)"/>
					</xsl:attribute>
					<rdf:type>
						<xsl:attribute name="rdf:resource">
							<xsl:value-of select="$className"/>
						</xsl:attribute>
					</rdf:type>
				</owl:NamedIndividual>
			</xsl:if>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
