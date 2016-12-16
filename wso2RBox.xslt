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
		>
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/wso2:definitions">
		<rdf:RDF xmlns="http://www.bls.ch/soa/ontologies/wso2/2016/12/ESB"
						xmlns:base="http://www.bls.ch/soa/ontologies/wso2/2016/12/ESB"
						xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
						xmlns:owl="http://www.w3.org/2002/07/owl#"
						xmlns:xml="http://www.w3.org/XML/1998/namespace"
						xmlns:wso2="http://ws.apache.org/ns/synapse"
						xmlns:fn="http://www.w3.org/2005/xpath-functions"
						xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
						xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
						xmlns:tbox="http://www.bls.ch/soa/ontologies/wso2/2016/12/TBox#"
						xmlns:xs="http://www.w3.org/2001/XMLSchema" 
						xmlns:core-soa="http://www.semanticweb.org/ontologies/2010/01/core-soa.owl#"
						>
			<owl:Ontology rdf:about="http://www.bls.ch/soa/ontologies/wso2/2016/12/RBox">
				<owl:imports rdf:resource="http://www.bls.ch/soa/ontologies/wso2/2016/12/ABox"/>
			</owl:Ontology>

		<rdf:Description rdf:about="http://www.bls.ch/soa/ontologies/wso2/2016/12/RBox#contains">
			<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#ObjectProperty"/>
			<rdfs:subPropertyOf rdf:resource="http://www.semanticweb.org/ontologies/2010/01/core-soa.owl#uses"/>
			<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#TransitiveProperty"/>
		</rdf:Description>
		<rdf:Description rdf:about="http://www.bls.ch/soa/ontologies/wso2/2016/12/RBox#containedBy">
			<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#ObjectProperty"/>
			<rdfs:subPropertyOf rdf:resource="http://www.semanticweb.org/ontologies/2010/01/core-soa.owl#usedBy"/>
			<owl:inverseOf rdf:resource="http://www.bls.ch/ontologies/ticketAccounting.owl#contains"/>
		</rdf:Description>
<!--  -->
<!-- http://www.bls.ch/ontologies/ticketAccounting.owl#contains -->


			
			<!-- Assert to call-template -->
			<xsl:comment> === Assert to call-template === </xsl:comment>
			<xsl:for-each select="*/*/*/wso2:call-template">
				<xsl:if test="fn:exists(../../../@name)">
					<!-- Assert individuals to properties -->
					<owl:NamedIndividual>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="fn:concat('#', ../../../@name)"/>
						</xsl:attribute>
						<core-soa:uses>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="fn:concat('#',@target)"/>
							</xsl:attribute>
						</core-soa:uses>
					</owl:NamedIndividual>
				</xsl:if>
			</xsl:for-each>

			<!-- Assert to sequence -->
			<xsl:comment> === Assert to sequence === </xsl:comment>
			<xsl:for-each select="*">
				<xsl:if test="fn:exists(@sequence)">
					<!-- Assert individuals to properties -->
					<owl:NamedIndividual>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="fn:concat('#', @name)"/>
						</xsl:attribute>
						<core-soa:uses>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="fn:concat('#',@sequence)"/>
							</xsl:attribute>
						</core-soa:uses>
					</owl:NamedIndividual>
				</xsl:if>
			</xsl:for-each>

			<!-- Assert to store -->
			<xsl:comment> === Assert to store === </xsl:comment>
			<xsl:for-each select="*/*/*/wso2:store">
				<xsl:if test="fn:exists(../../../@name)">
					<!-- Assert individuals to properties -->
					<owl:NamedIndividual>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="fn:concat('#', ../../../@name)"/>
						</xsl:attribute>
						<core-soa:uses>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="fn:concat('#',@messageStore)"/>
							</xsl:attribute>
						</core-soa:uses>
					</owl:NamedIndividual>
				</xsl:if>
			</xsl:for-each>

			<!-- Assert to send -->
			<xsl:comment> === Assert to send === </xsl:comment>
			<xsl:for-each select="*/*/*/*/wso2:endpoint">
				<xsl:if test="fn:exists(../../../../@name)">
					<!-- Assert individuals to properties -->
					<owl:NamedIndividual>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="fn:concat('#', ../../../../@name)"/>
						</xsl:attribute>
						<core-soa:uses>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="fn:concat('#',@key)"/>
							</xsl:attribute>
						</core-soa:uses>
					</owl:NamedIndividual>
				</xsl:if>
			</xsl:for-each>

			<!-- Assert to schema -->
			<xsl:comment> === Assert to schema === </xsl:comment>
			<xsl:for-each select="*/wso2:validate/wso2:schema">
				<xsl:if test="fn:exists(../../@name)">
					<!-- Assert individuals to properties -->
					<owl:NamedIndividual>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="fn:concat('#', ../../@name)"/>
						</xsl:attribute>
						<core-soa:uses>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="fn:concat('#',@key)"/>
							</xsl:attribute>
						</core-soa:uses>
					</owl:NamedIndividual>
				</xsl:if>
			</xsl:for-each>
			
			<xsl:for-each select="*/*/wso2:validate/wso2:schema">
				<xsl:if test="fn:exists(../../../@name)">
					<!-- Assert individuals to properties -->
					<owl:NamedIndividual>
						<xsl:attribute name="rdf:about">
							<xsl:value-of select="fn:concat('#', ../../../@name)"/>
						</xsl:attribute>
						<core-soa:uses>
							<xsl:attribute name="rdf:resource">
								<xsl:value-of select="fn:concat('#',@key)"/>
							</xsl:attribute>
						</core-soa:uses>
					</owl:NamedIndividual>
				</xsl:if>
			</xsl:for-each>

		</rdf:RDF>
	</xsl:template>
	
</xsl:stylesheet>
