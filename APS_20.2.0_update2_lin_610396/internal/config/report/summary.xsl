<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" />
  <xsl:template match="/">
    <html>
      <style>
        .metric-name {
        font-weight: 600;
        min-width: 14em;
        display: inline-block;
        }

        .metric-value {
        margin-left: 1em;
        color: #336;
        }

        .metric-value-with-issue {
        margin-left: 1em;
        color: #C33;
        }

        li {
        list-style-type: none;
        }

        ul {
        margin-left: 1.5em;
        padding-left: 0em;
        }

        body {
        margin: 0;
        paddind: 0;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        color: #336;
        }

        pre {
        white-space:pre-wrap;
        max-width: 40em;
        color: #633;
        }

        .issue {
        border-left: 3px solid #C33;
        padding: 0.3em 0.3em 0.3em 1em;
        }

        table {
        margin: 0 1.5em;
        }

        th, td {
        text-align: left;
        }

        td {
        color: #333;
        }

        th {
        border-bottom: 2px solid #336;
        font-weight: 600;
        }

        .table-value {
        margin-right: 1.5em;
        }

        .brand {
        background-color: #0071c5;
        padding: 0.5em 1.5em;
        width: 100%;
        color: white;
        font-weight: 600;
        }

        .recommendation-placeholder {
        background-color: #eaecee;
        padding: 1em;
        }

        .recommendation-placeholder p {
        font-weight: 600;
        margin: 0;
        }

        .recommendation {
        border-left: 3px solid #bbb;
        padding: 0.3em 0.3em 0.3em 1em;
        margin: 0 0 0 1.5em;
        }

        .recommendation-metric {
        font-weight: 600;
        min-width: 14em;
        display: inline-block;
        margin: 0 0 0 1.5em;
        }

      </style>
      <body>
        <div class="brand">Intel® VTune™ Profiler 2020 Update 2</div>
        <xsl:apply-templates select="/root/recommendations"/>
        <xsl:apply-templates select="/root/metric"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="recommendations">
    <div class="recommendation-placeholder">
      <p>Recommendations:</p>
      <xsl:for-each select="recommendation">
        <span class="recommendation-metric">
          <xsl:value-of select="current()/metric/@name" />: <xsl:value-of select="current()/metric/formatted_value" />
        </span>
        <pre class="recommendation">
          <xsl:value-of select="current()/text"/>
        </pre>
      </xsl:for-each>
    </div>
  </xsl:template>

  <xsl:template match="metric">
    <ul>
      <li>
        <span class="metric-name">
          <xsl:value-of select="@name" />:
        </span>
        <xsl:choose>
          <xsl:when test="issues">
            <span class="metric-value-with-issue">
              <xsl:value-of select="formatted_value" />
              <xsl:apply-templates select="issues"/>
            </span>
          </xsl:when>
          <xsl:otherwise>
            <span class="metric-value">
              <xsl:value-of select="formatted_value" />
            </span>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:apply-templates select="metric"/>
        <xsl:apply-templates select="table"/>
      </li>
    </ul>
  </xsl:template>

  <xsl:template match="table">
    <table>
      <tr>
        <xsl:for-each select="columns/column">
          <th>
            <span  class="table-value">
              <xsl:value-of select="current()"/>
            </span>
          </th>
        </xsl:for-each>
      </tr>
      <xsl:for-each select="row">
        <tr>
          <xsl:for-each select="value/formatted_value">
            <td>
              <span  class="table-value">
                <xsl:value-of select="current()"/>
              </span>
            </td>
          </xsl:for-each>
        </tr>
      </xsl:for-each>
    </table>
  </xsl:template>

  <xsl:template match="issues">
    <xsl:if test="issue">
      <div class="issues">
        <xsl:for-each select="issue">
          <pre class="issue">
            <xsl:value-of select="current()"/>
          </pre>
        </xsl:for-each>
      </div>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
