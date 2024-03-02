import "../scss/checklist.scss";
import { Title } from "@solidjs/meta";

function Checklist() {
	return (
		<main class="checklist">
			<Title>Checklist</Title>
			<table>
				<thead>
					<tr>
						<th>Section and Topic</th>
						<th>Item #</th>
						<th>Checklist Item</th>
						<th>Location where item is reported</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>TITLE</td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td>Title</td>
						<td>1</td>
						<td>Identify the report as a systematic review</td>
						<td></td>
					</tr>
					<tr>
						<td>ABSTRACT</td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td>Abstract</td>
						<td>2</td>
						<td>See the PRISMA 2020 for Abstracts checklist</td>
						<td></td>
					</tr>
					<tr>
						<td>INTRODUCTION</td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td>Rationale</td>
						<td>3</td>
						<td>
							Describe the rationale for the review in the context of existing
							knowledge.
						</td>
						<td></td>
					</tr>
					<tr>
						<td>Objectives</td>
						<td>4</td>
						<td>
							Provide an explicit statement of the objective(s) or question(s)
							the review addresses.
						</td>
						<td></td>
					</tr>
					<tr>
						<td>METHODS</td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td>Eligibility criteria</td>
						<td>5</td>
						<td>
							Specify the inclusion and exclusion criteria for the review and
							how studies were grouped for the syntheses.
						</td>
						<td></td>
					</tr>
					<tr>
						<td>Information sources</td>
						<td>6</td>
						<td>
							Specify all databases, registers, websites, organisations,
							reference lists and other sources searched or consulted to
							identify studies. Specify the date when each source was last
							searched or consulted.
						</td>
						<td></td>
					</tr>
					<tr>
						<td>Search strategy</td>
						<td>7</td>
						<td>
							Present the full search strategies for all databases, registers
							and websites, including any filters and limits used.
						</td>
						<td></td>
					</tr>
					<tr>
						<td>Selection process</td>
						<td>8</td>
						<td>
							Specify the methods used to decide whether a study met the
							inclusion criteria of the review, including how many reviewers
							screened each record and each report retrieved, whether they
							worked independently, and if applicable, details of automation
							tools used in the process.
						</td>
						<td></td>
					</tr>
					<tr>
						<td>Data collection process</td>
						<td>9</td>
						<td>
							Specify the methods used to collect data from reports, including
							how many reviewers collected data from each report, whether they
							worked independently, any processes for obtaining or confirming
							data from study investigators, and if applicable, details of
							automation tools used in the process.
						</td>
						<td></td>
					</tr>
					<tr>
						<td>Data items</td>
						<td>10a</td>
						<td>
							List and define all outcomes for which data were sought. Specify
							whether all results that were compatible with each outcome domain
							in each study were sought (e.g. for all measures, time points,
							analyses), and if not, the methods used to decide which results to
							collect.
						</td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td>10b</td>
						<td>
							List and define all other variables for which data were sought
							(e.g. participant and intervention characteristics, funding
							sources). Describe any assumptions made about any missing or
							unclear information.
						</td>
						<td></td>
					</tr>
					<tr>
						<td>Study risk of bias assessment</td>
						<td>11</td>
						<td>
							Specify the methods used to assess risk of bias in the included
							studies, including details of the tool(s) used, how many reviewers
							assessed each study and whether they worked independently, and if
							applicable, details of automation tools used in the process.
						</td>
						<td></td>
					</tr>
					<tr>
						<td>Effect measures</td>
						<td>12</td>
						<td>
							Specify for each outcome the effect measure(s) (e.g. risk ratio,
							mean difference) used in the synthesis or presentation of results.
						</td>
						<td></td>
					</tr>
					<tr>
						<td>Synthesis methods</td>
						<td>13a</td>
						<td>
							Describe the processes used to decide which studies were eligible
							for each synthesis (e.g. tabulating the study intervention
							characteristics and comparing against the planned groups for each
							synthesis (item #5)).
						</td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td>13b</td>
						<td>
							Describe any methods required to prepare the data for presentation
							or synthesis, such as handling of missing summary statistics, or
							data conversions.
						</td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td>13c</td>
						<td>
							Describe any methods used to tabulate or visually display results
							of individual studies and syntheses.
						</td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td>13d</td>
						<td>
							Describe any methods used to synthesize results and provide a
							rationale for the choice(s). If meta-analysis was performed,
							describe the model(s), method(s) to identify the presence and
							extent of statistical heterogeneity, and software package(s) used.
						</td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td>13e</td>
						<td>
							Describe any methods used to explore possible causes of
							heterogeneity among study results (e.g. subgroup analysis,
							meta-regression).
						</td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td>13f</td>
						<td>
							Describe any sensitivity analyses conducted to assess robustness
							of the synthesized results.
						</td>
						<td></td>
					</tr>
					<tr>
						<td>Reporting bias assessment</td>
						<td>14</td>
						<td>
							Describe any methods used to assess risk of bias due to missing
							results in a synthesis (arising from reporting biases).
						</td>
						<td></td>
					</tr>
					<tr>
						<td>Certainty assessment</td>
						<td>15</td>
						<td>
							Describe any methods used to assess certainty (or confidence) in
							the body of evidence for an outcome.
						</td>
						<td></td>
					</tr>
					<tr>
						<td>RESULTS</td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td>Study selection</td>
						<td>16a</td>
						<td>
							Describe the results of the search and selection process, from the
							number of records identified in the search to the number of
							studies included in the review, ideally using a flow diagram.
						</td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td>16b</td>
						<td>
							Cite studies that might appear to meet the inclusion criteria, but
							which were excluded, and explain why they were excluded.
						</td>
						<td></td>
					</tr>
					<tr>
						<td>Study characteristics</td>
						<td>17</td>
						<td>Cite each included study and present its characteristics.</td>
						<td></td>
					</tr>
					<tr>
						<td>Risk of bias in studies</td>
						<td>18</td>
						<td>
							Present assessments of risk of bias for each included study.
						</td>
						<td></td>
					</tr>
					<tr>
						<td>Results of individual studies</td>
						<td>19</td>
						<td>
							For all outcomes, present, for each study: (a) summary statistics
							for each group (where appropriate) and (b) an effect estimate and
							its precision (e.g. confidence/credible interval), ideally using
							structured tables or plots.
						</td>
						<td></td>
					</tr>
					<tr>
						<td>Results of syntheses</td>
						<td>20a</td>
						<td>
							For each synthesis, briefly summarise the characteristics and risk
							of bias among contributing studies.
						</td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td>20b</td>
						<td>
							Present results of all statistical syntheses conducted. If
							meta-analysis was done, present for each the summary estimate and
							its precision (e.g. confidence/credible interval) and measures of
							statistical heterogeneity. If comparing groups, describe the
							direction of the effect.
						</td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td>20c</td>
						<td>
							Present results of all investigations of possible causes of
							heterogeneity among study results.
						</td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td>20d</td>
						<td>
							Present results of all sensitivity analyses conducted to assess
							the robustness of the synthesized results.
						</td>
						<td></td>
					</tr>
					<tr>
						<td>Reporting biases</td>
						<td>21</td>
						<td>
							Present assessments of risk of bias due to missing results
							(arising from reporting biases) for each synthesis assessed.
						</td>
						<td></td>
					</tr>
					<tr>
						<td>Certainty of evidence</td>
						<td>22</td>
						<td>
							Present assessments of certainty (or confidence) in the body of
							evidence for each outcome assessed.
						</td>
						<td></td>
					</tr>
					<tr>
						<td>DISCUSSION</td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td>Discussion</td>
						<td>23a</td>
						<td>
							Provide a general interpretation of the results in the context of
							other evidence.
						</td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td>23b</td>
						<td>
							Discuss any limitations of the evidence included in the review.
						</td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td>23c</td>
						<td>Discuss any limitations of the review processes used.</td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td>23d</td>
						<td>
							Discuss implications of the results for practice, policy, and
							future research.
						</td>
						<td></td>
					</tr>
					<tr>
						<td>OTHER INFORMATION</td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td>Registration and protocol</td>
						<td>24a</td>
						<td>
							Provide registration information for the review, including
							register name and registration number, or state that the review
							was not registered.
						</td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td>24b</td>
						<td>
							Indicate where the review protocol can be accessed, or state that
							a protocol was not prepared.
						</td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td>24c</td>
						<td>
							Describe and explain any amendments to information provided at
							registration or in the protocol.
						</td>
						<td></td>
					</tr>
					<tr>
						<td>Support</td>
						<td>25</td>
						<td>
							Describe sources of financial or non-financial support for the
							review, and the role of the funders or sponsors in the review.
						</td>
						<td></td>
					</tr>
					<tr>
						<td>Competing interests</td>
						<td>26</td>
						<td>Identify the report as a systematic review.</td>
						<td></td>
					</tr>
					<tr>
						<td>Availability of data, code and other materials</td>
						<td>27</td>
						<td>
							Report which of the following are publicly available and where
							they can be found: template data collection forms; data extracted
							from included studies; data used for all analyses; analytic code;
							any other materials used in the review.
						</td>
						<td></td>
					</tr>
				</tbody>
			</table>
		</main>
	);
}

export default Checklist;
