= CrossWave: Cross-detector Attention for the Detection and Parameterisation of Overlapping Gravitational-Wave Compact Binary Coalescences <crosswave-sec>

Thus far, we have focused our attention on perhaps one of the simpler problems in gravitational-wave data analysis, transient detection; the fact remains, that many, more complex, tasks are yet to be satisfactorily solved. One of the largest and most intriguing of these is Parameter Estimation (PE). Whilst detection merely identifies the presence of a signal, and, in a modeled search, tells us the type of signal we have detected, there is invariably other scientifically valuable information that can be extracted from a signal. During PE, we attempt to predict, with error margins, several parameters about a gravitational-wave-producing system. Typically this is a CBC system, although PE could also be performed on burst events if they were to be detected. Fortunately, CBCs can be described quite well in as few as 14 parameters that contain information both about the state of a CBC system, known as intrinsic parameters, and its relation to us as observers, known as extrinsic parameters. Care should be taken to distinguish between the parameters being extracted by PE, and the parameters of a neural network model, as they are unrelated.

Without further analysis, detection alone is useful for little more than rudimentary population analysis; PE is a crucial part of gravitation wave science. Extrinsic parameters, like the source distance and sky location, aid in population studies and multimessenger analysis, and intrinsic parameters such as the companion mass and spin properties can help unveil information about the sources themselves.

This section does not focus on a general PE method for either CBC or burst signals. Those have both been well investigated and although there is arguably a greater room for improvement and a larger need for innovation on these fronts than in detection alone it was not within the scope of this work. In this section, we present an analysis of a much smaller subproblem within PE; the detection and isolation, of overlapping waveforms. Because of the somewhat limited nature of the problem, it has not been studied as thoroughly as any of the other problems we have yet examined, which, in some ways, gives us more space for exploration, and an increased potential for novel scientific output.

== Frequency of Overlapping Compact Binary Coalescences (CBCs)

Significant improvements to our gravitational wave detection capability are anticipated within the next decade, with improvements to existing detectors such as LIGO-Voyager @LIGO_Voyager, as well as future 3#super("rd") and 4#super("th") generation space and ground-based detectors such as the Einstein Telescope (ET) @einstein_telescope, Cosmic Explorer (CE) @cosmic_explorer, and the Laser Interferometer Space Antenna (LISA) @LISA. Whilst the current detection rate ($1~2 space "week"^(-1)$ [BBHs]) and average detectable duration ($~7 s$ [BBHs]) of Compact Binary Coalescence (CBC) detection is too low for any real concern about the possibility of overlapping detections @bias_study_one, estimated detection rates ($50~300 space "week"^(-1)$ [BBHs]) and durations ($40~20000 s$ [BBHs]) for future networks will render such events a significant percentage of detections @bias_study_one, see @overlaping-event-rate for a more detailed breakdown of overlapping event estimates. Contemporary detection and parameter pipelines do not currently have any capabilities to deal with overlapping signals --- and although, in many cases, detection would still be achieved @bias_study_one @bias_study_two, PE would likely be compromised by the presence of the overlap, especially if more detailed information about higher modes and spins @bias_study_one are science goals.


#figure(
  table(
    columns: (auto, auto, auto, auto, 80pt, 70pt, 70pt),
    inset: 10pt,
    align: horizon,
    [*Configuration*],  [*Range (MPc)*], [*Cut Off (Hz)*], [*Mean Visible Duration (s)*], [*P(Overlap) ($"year"^(-1)$)*], [*$N_"events"$ ($"year"^(-1)$)*], [*$N_"overlaps"$ \ ($"year"^(-1)$)*],
    [aLIGO: O3], [611.0], [20], [6.735], [$3.9_(-1.3)^(+1.9) times 10^(-6)$], [$42.0_(-13.0)^(+21.0)$], [$0.0_(-0.0)^(+0.0)$],
    [aLIGO: O4], [842.5], [20], [6.735], [$1.0_(-0.3)^(+0.5) times 10^(-5)$], [$100.0_(-29.0)^(+56.0)$], [$0.0_(-0.0)^(+0.0)$],
    [aLIGO: Design], [882.9], [20], [6.735], [$1.2_(-0.4)^(+0.6) times 10^(-5)$], [$120.0_(-38.0)^(+60.0)$], [$0.0_(-0.0)^(+0.0)$],
    [LIGO-Voyager], [2684.0], [10], [43.11], [$2.3_(-0.8)^(+1.2) times 10^(-3)$], [$2700.0_(-38.0)^(+60.0)$], [$6.3_(-3.4)^(+7.7)$],
    [Einstein Telescope], [4961.0], [1], [19830.0], [$1.0_(-0.0)^(+0.0)$], [$15000.0_(-5000.0)^(+7100.0)$], [$15000.0_(-5000.0)^(+7100.0)$],
  ),
  caption: [Estimated overlap rates of BBH signals in current and future detectors, sourced from Relton @phil_thesis. Presented error values are 90% credible intervals. Note that these are estimates of rates, including for past observing runs rather than real values, and are meant only as an illustration of the difference in overlap rates between current and future detector configurations. The number of overlapping signals, $N_"overlap"$, anticipated within one year is determined by the number of detections, $N_"events"$, and the visible duration of those detections, which are, in turn, affected by the detection range and lower frequency cut off of that detector configuration. We can see that although with the current and previous detector configurations an overlapping event is extremely unlikely, it will increase with LIGO-Voyager to the point where we would expect $6.3_(-3.4)^(+7.7)$ per year, and further increase with the Einstein telescope to the point where we would not expect any event to be detected without components of other signals also present in the detector. ]
) <overlaping-event-rate>

== Detection and Parameter Estimation (PE) of Overlapping Compact Binary Coalescences (CBCs)

Two studies examined the rate at which overlaps were likely to occur with different detector configurations and the effect of overlapping signals on PE. Samajdar _et al._ @bias_study_one, determined that during an observing period of the future Einstein telescope, the typical BNS signal will have tens of overlapping BBH signals and that there will be tens of thousands of signals that have merger times within a few seconds of each other. They found that for the most part, this had little effect on parameter recovery except in cases where a short BBH or quiet BNS overlapped with a louder BNS signal. Relton and Raymond @bias_study_two performed a similar study and produced the overlap estimates seen in @overlaping-event-rate. They found that PE bias was minimal for the larger of the two signals when the merger time separation was greater than #box($0.1$ + h(1.5pt) + "s") and when the SNR of the louder signal was more than three times that of the quieter signal. This bias was also smaller when the two signals occupied different frequency regions, and when the louder of the two signals appeared first in the detector stream. Despite this, they found evidence of PE bias even when the smaller signal was below the detectable SNR threshold. They found that overlapping signals can mimic the effects of procession, it will be important to be able to distinguish the two when detailed procession analysis becomes possible.

Much of the work in this area focuses on performing PE with overlapping signals, and there has not been as much attention to distinguishing pairs of mergers from single mergers. Relton _et al._ @overlapping_search measured the detection performance of both a modeled (PyCBC) @pycbc and unmodeled (coherent WaveBurst [cWB]) @cWB search pipeline when searching for overlapping signals. They determined that both pipelines were able to recover signals with minimal efficiency losses ($<1%$) although they noted that the clustering algorithm used in both pipelines was inadequate to separate the two events, noting that cWB could detect both events. They concluded that adjustments to clustering could be made to both pipelines in order to return both events given a sufficient merger time separation. Using these altered pipelines it would then be possible to separate the data into two regions, which could be used for independent PE.

Once an overlapping single has been identified, the next step is to deal with PE. Although in many cases, existing PE techniques may provide results with little bias @bias_study_one @bias_study_two, there are some situations in which this may not be the case. If the PE method can be improved in order to reduce that bias, it is useful in any case, so long as it does not result in a reduction of PE accuracy that is greater than the bias introduced by the overlapping signal.

There are four types of methods we can apply to alleviate the issues with PE @phil_thesis. 

+ *Global-fit* methods attempt to fit both signals simultaneously. There have been several studies investigating this method by Antonelli _et al._ @global_fit, which attempts to apply it to both Einstein Telescope and LISA data, @hieherachical_overlapping_pe_2 which compares this method to hierarchical subtraction, and several studies focusing solely on LISA data @lisa_global_1 @lisa_global_2 @lisa_global_3. This has the advantage of being somewhat a natural extension of existing methods, with no special implementation simply an increased parameter count, but that can also be its greatest disadvantage. The total number of parameters can quickly become large when an overlap is considered, especially if multiple overlaps are present which will be expected to occur in ET and LISA data.

+ *Local-fit* methods attempt to fit each signal independently and correct for the differences. The original proposal by Antonelli _et al._  @global_fit suggests using local fits to supplement a global-fit approach. Evidently, this will reduce the number of parameters that you require your method to fit, but its efficacy is highly dependent on the efficacy of your correction method.

+ *Hierarchical Subtraction* methods suggest first fitting to the most evident signal, then subtracting the signal inferred from your original data and repeating the process @hiherachical_subtration_overlapping_pe @hieherachical_overlapping_pe_2. This method would be effective at subtracting multiple sets of parameters for overlapping signals, assuming that the overlap does not cause bias in the initial fit, which the previously mentioned studies have shown is not always a correct assumption @bias_study_one @bias_study_two. This method can also be augmented with machine learning methods

+ Finally, and most relevantly, *machine learning* methods can be employed as a global fit technique to try and extract parameters from overlapping signals. They come with all the usual advantages, (inference speed, flexibility, computational backloading) and disadvantages (lack of interpretability, unpredictable failure modes). Langendorff _et al._ @machine_learning_overlapping_pe attempt to use Normalising Flows to output estimations for parameters.

Most of the methods mentioned benefit from having prior knowledge about each of the pairs of signals, especially the merger times of each signal. As well as acting as a method to distinguish between overlapping and lone signals, CrossWave was envisioned as a method to extract the merger times of each of the binaries in order to assist further PE techniques. Crosswave was able to achieve this and also demonstrated some more general, but limited PE abilities.

== CrossWave Method

We introduce CrossWave, two attention-based neural network models for the identification and PE of overlapping CBC signals. CrossWave consists of two complementary models, one for the separation of the overlapping case from the non-overlapping case and the second as a PE follow-up to extract the merger times of the overlapping signals in order to allow other PE methods to be performed. CrossWave can differentiate between overlapping signals and lone signals with efficiencies matching that of more conventional matched filtering techniques but with considerably lower inference times and computational costs. We present a second PE model, which can extract the merger times of the two overlapping CBCs. We suggest CrossWave or a similar architecture may be used to augment existing CBC detection and PE infrastructure, either as a complementary confirmation of the presence of overlap or to extract the merger times of each signal in order to use other PE techniques on the separated parts of the signals.

Since the CrossWave project was an exploratory investigation rather than an attempt to improve the results of a preexisting machine learning method, it has a different structure to the Skywarp project. Initially, we applied architecture from the literature, again taking Gabbard _et al._ @gabbard_messenger_cnn, with architecture illustrated here @gabbard_diagram. This worked effectively for the differentiation of overlapping and lone signals. We named this simpler method was called OverlapNet. However, when attempting to extract the signal merger times from the data, we found this method to be inadequate, therefore, we utilized the attention methods described in @skywarp-sec, along with insights gained over the course of other projects to construct a more complex deep network for the task, seen in @crosswave-large-diagram. We name this network CrossWave, as it utilises cross attention between a pair of detectors. It is hoped that this architecture can go on to be used in other problems, as nothing in its architecture, other than its output features, has been purpose-designed for the overlapping waveform case.

=== Crosswave Training, Testing, and Validation Data <crosswave-data>

The dataset utilized in this section differs from previous sections, in that it was not generated using the GWFlow data pipeline. Since this was part of a PE investigation, the exact morphology of the waveforms injected into the signal is crucial to validating performance. The cuPhenom IMPhenomD waveform generator that was developed for rapid waveform generation on the GPU has a relatively high degree of mismatch (~5%) with IMPhenomD signals generated with LALSimulation in some areas of parameter space. This is thought primarily to be down to reduced precision operation (32-bit in most areas rather than 64-bit) and the lack of implementation of some post-Fourier conditioning steps. Whilst this mismatch was deemed to be mostly adequate for detection searches, especially for comparison of methods, we considered it inadequate for PE tasks. IMRPhenomD is also an older waveform aproximant, which does not take into consideration, the latest improvements to waveform aproximation and some physical phenomena, such as higher modes. Whilst there is currently no one waveform approximant that can generate waveforms that include all physical effects, we opted to use IMRPhenomTPHM, which is a Time-Domain approximant that includes the physics of precession, which allows for studies of Higher Modes.

A static dataset was created using BBH waveforms generated using LALSimulation and injected into Gaussian noise coloured by the LIGO Hanford and LIGO Livingston aLIGO design specifications using the technique described in @noise_acquisition_sec but not with the GWFlow pipeline. No BNS signals were considered. We used a #box("16" + h(1.5pt) + "s") on-source duration, to allow more space for different signal start times and to examine the effects of distant signal overlap on PE. We used a sample rate of #box($1024$ + h(1.5pt) + "Hz"), as this was considered adequate to contain the vast majority of relevant frequency content for the CBCs examined.

Unlike in the detection case, wherein our training distribution consisted of some examples with obfuscated signals and some consisting of pure noise. For this case, we assume that a detection has already been made by a detection pipeline, so our examples always contain signal content of some kind. This assumption was made to simplify the task to its minimal possible case. Our generated waveform bank consisted of $20^5$ IMRPhenomTPHM approximants. From that template bank, we constructed $20^5$ of lone signals injected into obfuscated noise and $20^5$ pairs of signals injected into obfuscated noise, totaling $40^5$ training examples. In the latter case, each waveform was unique to a single pair, generating $10^5$ pairs, but each pair was injected into two different noise realizations in order to generate identical numbers of lone and paired templates. The use of the same waveforms in both the single case and the pairs was a conscious decision that was made in order to attempt to reduce the change of the network overfitting to any particular signal morphology.

The waveforms were generated with a wide parameter range uniformly drawn from across parameter space. The primary component of each waveform was generated with masses between #box("10.0" + h(1.5pt) + $M_dot.circle$) and #box("70.0" + h(1.5pt) + $M_dot.circle$), this is notably inconsistent with our previous studies, but was reduced to reduce task complexity and because this still covers most of the range that is of interest to PE studies. This also ensured that their visual duration, between #box("20.0" + h(1.5pt) + "Hz"), which is both the whitening low-pass filter and around the limit that the detector design curve starts to make detection impossible, remained well contained within the #box("16" + h(1.5pt) + "s") on-source duration. Also unlike in our previous detection studies, the mass ratio was constrained between 0.1 and 1. Since the approximants were generated in an alternate method utalising luminosity distance as the scaling factor rather than SNR, the SNRs are not uniformly distributed, however, the Network SNR of any signal is not less than 5 or greater than 100. For each injection luminosity distance in MPc was drawn from a power law distribution with base two scaled by 145, with a minimum distance of #box("5.0" + h(1.5pt) + "MPc"), this luminosity distance range was generated by a trial and error approach to achieve the desired SNR distribution.  An overview of the parameters used to train both the CrossWave and Overlapnet models is shown in @overlap_injection_examples.

A validation dataset was also generated with independent signals and background noise, with $20^4$ singles and $20^4$ pairs generated similarly to the training data, totaling $40^4$ validation examples.

#figure(
  table(
    columns: (auto, auto),
    inset: 10pt,
    align: horizon,
    [*Hyperparameter*],  [*Value*],
    [Batch Size], [32],
    [Learning Rate], [10#super("-4")],
    [Optimiser], [ Adam ],
    [Scaling Method], [Luminosity Distance],
    [Min Luminosity Distance], [5.0],
    [Max Luminosity Distance], [N/A],
    [Luminosity Distance Distribution], [$ ("Power-Law (base 2)" times 145) + 5 "MPc"$ ],
    [Data Acquisition Batch Duration], [ N/A ],
    [Sample Rate], [ #box("1024.0" + h(1.5pt) + "Hz")],
    [On-source Duration], [ #box("16.0" + h(1.5pt) + "s")],
    [Off-source Duration], [ N/A ],
    [Scale Factor], [10#super("21") ],
    
  ),
  caption: [The training and dataset hyperparameters used in Crosswave experiments. ]
) <skywarp-training-parameters>

In the case of the pairs of injection, the two waveforms are injected so that their merger times never have a separation exceeding #box("2" + h(1.5pt) + "s"). "Signal A" is defined as the signal that arrives second, whereas "Signal B" is always defined as the signal that arrives first. This allows the model to differentiate between the two signals for the PE tasks. When only one waveform is present, that waveform is labeled "Signal A".

#figure(
    grid(
        columns: 1,
        rows:    2,
        gutter: 1em,
        [ #image("single_example.png", width: 80%) ],
        [ #image("overlap_example.png", width: 80%) ]
    ),
    caption: [Two illustrative examples of data used to train CrossWave, the upper in the single signal case, the lower in the multiple signal case. Since the real data used to train CrossWave was unwhitened, it is not easy to parse by eye. Thus, as an illustrative example, these two examples are shown in whitened data generated using cuPhenom and GWFlow. The example duration has also been cropped from #box("16" + h(1.5pt) + "s") to #box("5" + h(1.5pt) + "s"), since the merger times never have a separation greater than #box("2" + h(1.5pt) + "s") this is ample as an example. Both examples show time series from both detectors, simulating LIGO Livingstone and LIGO Hanford. _Upper:_ Single waveform injected into noise drawn from the two LIGO detectors. _Lower:_ A pair of waveforms injected into noise drawn from the two LIGO detectors. The waveforms are always injected with merger times less than #box("2" + h(1.5pt) + "s") distant.] 
) <overlap_injection_examples>


==== A note on Whitening

Interestingly, since the data was generated independently, it was not whitened prior to model injection. Since this is not a comparison to another machine learning method that uses whitening, this is not particularly an issue, but it also can't tell us about the efficacy we have lost/gained due to the lack of whitening. Since this investigation does have positive results, this could potentially be an area for future experimentation, forgoing the whitening step before ingestion by a model would streamline a lot of the problems faced by low-latency machine learning pipelines. 

This may also have some benefits in the case of overlapping signal detection and PE. Because it is expected to only become relevant in the regime of very long-lived signals, it may be difficult to get clean off-source data at a close enough time separation from the on-source data.

== Overlapnet Results

=== Clasification

The first attempt to classify input examples generated with the method described in @crosswave-data utilized an architecture from the literature taken from Gabbard _et al._ @gabbard_messenger_cnn, the model architecture of this model can be seen at @gabbard_diagram. To distinguish this model from later models, this model was named Overlapnet. We trained a binary classifier to output a score near or equal to one if there were two signals present in the input data, and a score near or equal to zero if there was only one signal in the data.

Since data for this experiment was generated independently, validation was also performed alternately. Since we are assuming the presence of at least one signal, in either case, the problem is not hugely asymmetric as, in the CBC detection case, the penalty for incorrectly classifying a single signal as a double is much less than for classifying noise as a signal. If we assume that misidentifying a single signal as a double is as undesirable as misidentifying a pair of signals as a single, we can set a classification threshold of 0.5 so that neither class is favoured (unless the model intrinsically favours one class over another, which is also possible). This means we can focus on optimizing our model to gain as high accuracy as possible, without needing performance in extremely low FAR regimes, therefore FAR plots are not particularly useful.

The trained model was run over the validation dataset consisting of $40^4$ examples generated independently but with the same method as the training data. The parameters for each waveform were recorded and compared with the classification results. 

This initial attempt at applying a preexisting model from the literature to the problem proved sufficient even in unwhitened noise. The model was able to correctly classify most pair examples where both of the optimal network SNRs are above 10, and correctly identify almost all single signals. See @overlapnet_classification_scores.

For the single signal validation examples, the model can correctly identify these in almost all cases, (again assuming a detection threshold of 0.5). We note that although the classification error very rarely exceeds 0.5, there is still some notable error. It is thought that this may be because of deficiencies in the construction of the dataset. Since there is very little to differentiate between pairs of signals where one signal is rendered almost indetecable due to a small SNR, and single signals; and between pairs of signals where both detectors have a low SNR and a single signal with a low SNR, this adds significant confusion to the training process, which encourages the model to show less confidence when classifying signals as singles. This could be ameliorated by increasing the minimum SNR threshold of the signals to the point where no (or fewer) training examples have one undetectable single, although this change may come to the detriment of other classification abilities.

In the pair validation examples, the model has a much wider range of detection ability determined by the optimal network SNR of each of the examples' two signals. The model shows good performance above an SNR of ten, with a rapid decline below these values, which is roughly consistent with the efficiency curves we see in detection cases. This is anticipated when one of the signals has a low SNR, the example becomes very similar to a single signal; when both of the signals have a low SNR, the example becomes indistinguishable from a single signal with a low SNR. In both of these cases, the model prefers to classify examples as single signals rather than double. This makes sense, the model will try to minimize the difference between its output and the ground truth values, half the examples in the training dataset are single signals, whereas considerably less than half the signals are pairs of signals with one low SNR --- if the model has to guess between the two, it is more likely that the example will be in the former category than the latter. This is also probably true for real signals, so this is possibly not a bad feature of the classifier. For the case when both signals in a pair have low SNR, it also makes sense that the classifier would want to classify these as single signals, as there are many more examples of a single signal with a low SNR in the training dataset than there are of a pair of signals both with a low SNR.

It is also speculated that the model may have learned to associate low overall excess power with single signals. Since the two classes were not normalized to contain roughly equal excess power, the average excess power found in pair examples will be double that of the average excess power found in single examples. This is certainly a feature that the classifier could have learned to recognise. This could be alleviated by normalizing the excess power between the classes, which would force the detector to rely on the signal morphologies rather than excess power. It is not clear whether this would be a useful feature or not. Certainly, in nature, overlapping signals would, in general, mean greater excess power, but this may have detrimental effects in model training.

#figure(
    grid(
      columns: 2,
      rows:    1,
      gutter: 1em,
      [ #image("crosswave_classification_corrected.png",  width: 100%) ],
      [ #image("overlapnet_zoomed_classification.png",  width: 100%) ],
    ),
    caption: [Classification error of Overlapnet output when fed validation examples, plotted with Signal A optimal network SNR and Signal B Network SNR. A total of $4 times 10^4$ validation examples were used to produce this plot. All examples consist of two-channel synthetic detector noise generated by colouring Gaussian white noise with the LIGO Hanford and LIGO Livingston aLIGO design specifications. Half the validation examples were injected with one each of 20,000 IMRPhenomTPHM waveforms with no repetitions, these are the single injection examples, which only contain Signal A. In these cases the SNR of Signal B is always zero, these signals are seen arranged along the bottom of the plot. The other half of the examples consist of two each of the same 20,000 IMRPhenomTPHM waveforms with two repeats of the same pairs of signals injected into different noise realizations. A model score near one indicates the model has determined that the example has two hidden signals and a score near zero indicates that the model thinks the example has only one hidden signal. The classification score error shows the difference between the ground truth value and the predicted model output. Therefore an error nearer zero indicates good model performance, and an error nearer one indicates poor model performance. Assuming a classification threshold of 0.5 we can see that the model can successfully classify almost all single examples, and can successfully classify most pairs of single when the Network SNR of both signals is above an optimal SNR of 10. We note that although classification is achieved in most cases, there is still substantial error in many cases, though mostly below the threshold required for an inaccurate classification, 0.5. It is theorised that this is because the model is trained with many examples of pairs of detectors with one low SNR that are hard to distinguish from single detectors with one signal. This confusion could add considrable uncertainty to the model predictions, and it is recommended that if this project were to be repeated the minimum SNR threshold for both of the signals should be increased. When either of the optimal network SNRs of one of the signals falls below 10, the rate of classification error increases in a curve that is consistently shaped with the classification examples. This is anticipated --- in the case that one of the SNRs becomes low, the signal will appear to look like a single single as the other signal becomes hard to distinguish. In the case where both signals have a low SNR, both signals are hard to distinguish and it becomes difficult to differentiate between a single hard to identify signal and multiple hard to identify signals. In this latter case, where both signals have a low SNR, the model appears to favour classification as a single signal rather than double. It is hypothesized that this may be because the pairs and single examples were not normalized to consistent excess power, meaning that the total excess power contained in the set of all two signal examples will be double that of the total excess power in all single signal examples. This might bias the network to associate low excess power with single signal examples. _Left:_ Full validation results. _Right:_ Zoomed result for increased detail below optimal network SNRs of 50.]
) <overlapnet_classification_scores>

We also plot several pseudo-efficiency curves for easier comparison to other results in @overlapnet_efficiency_plots. Since there are now two network SNR values for each pair example, and one network SNR value for single examples, we present the result in five distinct efficiency curves, four curves for the pair examples, and one curve for the single example. The four curves for the pair examples are generated by sorting the dataset by maximum SNR of the pairs, minimum SNR of the pairs, and the SNR for signals A and B, then by generating a rolling average of the model score at these SNRs. The single signal SNR is generated by sorting by the lone SNR value and calculating a rolling average. Note that unlike previous efficiency curves, which displayed the percentage of results that were above a certain FAR-calibrated model threshold, these curves just plot the rolling average model predictions, which are correct at a score of one for the four pair curves, and correct at zero for the one single signal curve.

The minimum SNR signal curve reaches an average model score near one at a minimum network SNR of around 37, which is quite high. However, it still achieves relatively good scores above an optimal SNR of 16. The reason this curve appears with this different shape to the detection efficiency curves is presumably because there are factors other than the measured SNR that are relevant to the model performance. In all the pair examples, the other non-ranking SNR value will have a large effect on the model's ability to distinguish between the two cases, along with the merger time separation, and the parameter space difference between the two injections. Since the minimum network SNR is the only curve that reaches scores near one of the four curves for pair examples, we can infer that this is the bottleneck for detection ability, since the other curves never reach one no matter how high the network SNR.

The maximum SNR line, as expected shows considerably lower performance at lower SNRs. In each of the examples on this line, the lower SNR signal, which we know is the limiting factor, is equal to or lower than the SNR metric. This also explains why the line starts at a higher SNR --- because the line is a rolling average of the examples sorted by SNR metric, the first average SNR value for the maximum signals will naturally be higher than the first average of the minimum signals. Interestingly, the maximum SNR curve reaches approximate parity with the lines plotting effficiencies when sorted by the SNR of signals A and B. This is presumably because there is a large range of SNRs less than the maximum, so the lower SNR is likely to still be detectable, with the difference between this maximum efficiency and one due to the undetectable percentage of SNRs under this maximum value.

Curves were also plotted by sorting the pair validation results when sorted by Signal A SNR and Signal B SNR. These were plotted to see if the model had any bias between the signals. Signal B is defined as the signal that arrives first in the detection, so it might in theory be possible for the classifier to develop bias toward one signal or another. However, the results show very little difference between the two curves, suggesting that the model does not have a preference between which signal has the higher SNR. Again the model does not reach an average model score of one, but this is because the other SNR in the pair is unconstrained, so a certain percentage of examples at each average calculation will have a pairing with an SNR that is undetectable.

Finally, an efficiency curve was plotted for the single single examples. Only one curve was plotted for this example, as a single network SNR value can capture the entire SNR information content of the example. Note that in this case, a model prediction of zero rather than one is correct, so lower scores indicate a more accurate prediction. We see that the model performs best at SNR values less than 20, before plateauing and slowly increasing beyond that. This shape is created because the training data contained many pair examples with one low SNR value which would look very similar to single signal examples, creating confusion in the training process and leading the model to predict single signals with some uncertainty. The higher performance at low SNRs is presumably due to the excess power bias because there are considerably more single signal examples on the lower excess power end, the model can more confidently predict a single signal if the total excess power is low. For the same reason, model performance degrades at higher single signal SNRs as it is more likely there is higher excess power in double signal examples, although in double signal examples with high excess power the double morphologies are more likely to be visible, so this bias is considerably less than the low power bias demonstrated. 

#figure(
    image("overlapnet_efficiencies_2.png", width: 80%),
    caption: [Overlapnet of pair efficiency plots created from the combined overlapnet validation data pool using rolling averages with a window of 1000 and plotting every 100#super("th") average value. This plot gives an approximate comparison to the efficiency plots generated in the detection cases; although generation was done with a rolling average over a pool of logarithmically distributed SNRs rather than with pools of discrete SNRs at specific test SNR values that have been used previously in the detection cases. Also note that this plots the model output score, rather than the percentage of cases which fall above a calibrated SNR threshold. These efficiency plots show the relationship between the SNR values of one of the signals and the model prediction. One of the five lines gives the rolling average model score when the validation results pool is sorted by minimum SNR value. This is perhaps the most useful of the four lines as it is the bottleneck in classification ability. It reaches a classification score of 1.0 at a minimum optimal network SNR of around 37. It remains above 0.9 for SNRs above 19 and increases slowly until 37. This separates it from the detection case and is presumably because there are extra factors not accounted for on this plot, primarily the SNR of the second signal, but also things like the parameter space difference of the two waveforms and the merger time separation of the two waveforms, which could both add increased difficulty without being visible on the efficiency plot. Two of the lines plot the rolling average model score when plotted with the SNR of the two signals, Signal A and Signal B. Signal B always arrives before signal A. The similarity between these lines shows that it is unlikely there is any bias between whether Signal A has the lower SNR or Signal B. The maximum score achieved by this line is less than the minimum, as there are always low SNR signals in the average used to calculate this. The last of the four pair example lines shows the moving average when the validation pool is sorted by the maximum SNR of the two injected signals. This is the lowest still, as it is more likely that the uncounted-for signals have low SNR. Lastly, we show the single signal SNR scores, unlike the other signals, a lower score is better in this case, as a model prediction of zero indicates the lack of a second signal. We see that at low SNRs the score is lowest; this is expected as there are considerably more low SNR single signals in the dataset than pairs of signals, and this supports our hypothesis that the network is using excess power as a differentiation method. Above an optimal network SNR of 18 the classification score plateaus at an average of 0.2, as stated previously it is believed this is induced through confusing examples in the training dataset where it is almost impossible for the network to determine between a pair of signals where one signal is low and a single signal, teaching the network to guess with some uncertainty in all apparent single signal cases. We also see a slight decrease in prediction accuracy as SNR increases, again this probably results from the excess power bias. From this plot we can conclude that as expected the highest SNR signal is the largest factor in model efficiency, but that other factors are probably relevant.]
) <overlapnet_efficiency_plots>

We create additional plots to explore how classification performance varies with other areas in parameter space. First, we examine how the time difference between the arrival of Signal B and Signal A at the earth center (assumed to be very close to the arrival at any of the detectors, only in a very small number of cases will the order of arrival at the Earth's center be different from the arrival time at any detector when using this range of time separations), affects the classification performance. @overlapnet_classification_separation shows that there is little correlation between model performance and the arrival time difference, except when the time separation is very small. There appears to be some degradation of perfomance below #box("0.8" + h(1.5pt) + "s"), but this only becomes very significant below #box("0.2" + h(1.5pt) + "s"). Since the average model performance values are calculated using a rolling average, examining the distribution of individual example performance by eye, this last bin also seems to be heavily weighted by examples whose separation is very close to zero. As the time separation moves toward zero, the model has less opportunity to use distinct merger time peaks to aid in its classification and must begin to rely on morphology alone. Since the model maintains performance, though at a reduced efficiency, at separations down to zero seconds, we can determine that the model can use morphologies as well as distinct peaks, in order to distinguish between the two cases. Further analysis of a validation set consisting only of zero separated signals would be useful to examine this further. However, since signals arriving with such small separations is very unlikely even when detection rates are massively increased, this is not considered a priority.

#figure(
    image("overlapnet_classification_separation.png", width: 70%),
    caption: [Overlapnet classification results plotted against the time elapsed in seconds between the arrival of the merger of Signal B and Signal A. The coloured circles represent individual validation classification results, colour coded only for visual clarity, the red line is the moving average model prediction error at the stated time separation with a window of 500 validation examples. Only pairs are plotted, as single examples have no time separation. We see that for time differences above #box("0.8" + h(1.5pt) + "s") the separation has little effect on the average prediction error. Between #box("0.2" + h(1.5pt) + "s")  and #box("0.8" + h(1.5pt) + "s") there is a slight but notable increase in error, and below a merger time difference of #box("0.2" + h(1.5pt) + "s") there is a more notable uptick in error. It appears that this uptick at lower time separations is mostly caused by signals that have very low separation ($<$ #box("0.2" + h(1.5pt) + "s")) --- this seems to be the only significant predictor of model performance, other than this, and the small decrease in performance below #box("0.8" + h(1.5pt) + "s") the classifier seems to work with equal efficiency across time separations. This is perhaps less of a correlation than might be expected, but it demonstrates that only very close signals are problematic if at detectable SNRs. This is a good sign our the chances of developing a useful classifer. ]
) <overlapnet_classification_separation>

For our final analysis of the classification results, we explore the parameter space of the waveform by examining model performance at different values of chirp mass and mass ratio; see @overlapnet_classification_mass_parameters. These plots are less illuminatory, the only visible correlation exists between a lower chirp mass in one or both signals and poor performance. This is likely caused because sources will have a lower $h_"rss"$ and therefore SNR (assuming identical detector noise conditions, sky localization, and polarization) if they are at the same luminosity distance as another signal with a lower chirp mass. This is also corroborated by the decrease in single signal classification performance at higher chirp masses, which is seen with higher SNRs. However, if luminosity distance is variable, which it is in the dataset, chirp mass alone does not correspond directly to SNR. Thus we don't see as strong of a correlation as we see in @overlapnet_classification_scores. 

Since there is no visible correlation along the line where the two parameters are equal to each other, we can conclude that both waveforms having similar parameters have relatively little effect on the ability of the model to correctly classify the signal. This is slightly surprising, as we would expect signals with similar frequency contents to be more difficult for the model to separate. However, in most cases within the validation dataset, the arrival time separation was large enough that the model could use the distinct merger peaks as evidence for mergers rather than relying on the morphologies alone. Which may explain this seeming lack of dependence on waveform parameters.

#figure(
    grid(
        columns: 2,
        rows:    1,
        gutter: 1em,
        [ #image("overlapnet_classification_chirp_mass.png", width: 100%) ],
        [ #image("overlapnet_classification_mass_ratio.png", width: 100%) ]
    ),
    caption: [Overlapnet classification results compare with mass parameters of the constituent waveforms. _Left:_ Overlapnet classification scores plotted with source chirp masses for Signal A and Signal B. There appears to be some correlation between lower chirp masses and poor model performance, however, because there are highly performing examples even in cases where both chirp masses are low we can conclude that this is not the entire picture. It is hypothesized, that this correlation is primarily caused by the fact that lower chirp masses are more likely to produce a low SNR signal. If two sources were at the same luminosity distance but one had a higher chirp mass, the higher chirp mass would have a louder SNR (assuming identical detector noise conditions, sky localization, and signal polarisation). This hypothesis is supported by the lower model performance of single signals at higher chirp masses, as we have seen that single signal classification is slightly worse at higher SNRs. _Right:_ Overlapnet classification scores plotted with source mass ratio for Signal A and Signal B. This plot shows that there is very little, if any correlation between the mass ratio of the two signals, and model performance. This continues to show that signal morphology does not make a decisive difference in classification ability, which is primarily determined by the minimum SNR of a signal in the pairs, and secondarily weakened if the signals have a very small time separation. ]
) <overlapnet_classification_mass_parameters>

We conclude that Overlapnet is capable enough to differentiate between single and overlapping signals in the majority of cases, and with some adjustment to the training dataset, performance could probably be improved by removing the ambiguity generated in impossible-to-distinguish cases.

=== Regression

Following the relative success of Overlapnet in differentiating between examples with one CBC signal present and two overlapping CBC signals present, we attempted to use the same model, with an adjusted activation function on the last layer, (linear rather than softmax), to attempt a regression problem on pairs of overlapping signals, in an attempt to extract useful information that could be used in a parameter estimation pipeline. The most useful parameters that can be extracted from an overlapping signal, are the merger times of the two signals A and B. Using the same training dataset and procedure, we changed only the activation function applied to the model output to allow for regression rather than classification, the model loss function used, again to allow for regression, and the labels that the model was trained to output. Rather than output a score between zero and one, we trained the model to output a merger time for Signal A, and a merger time for Signal B. 

Due to an error in the data labeling procedure, which was not spotted until later experiments. Regression test results were extremely poor. Initially, it was thought that this was down to an insufficient for the task, therefore a much more complex and experimental network was constructed, utilizing much of the insight gained from previous experiments, as well as denoising autoencoder heads, and cross-attention layers between detectors. These concepts are explained in @additional-elements. We name this more complex network structure CrossWave.

== Aditional Structural Elements <additional-elements>
=== Cross-Attention <cross-attention-sec>

The multi-head attention layers we have explored thus far in @skywarp-sec have all consisted of self-attention heads, which is the most natural application of attention. However, attention layers can also be used to compare two different sequences; this is a principle component of the archetypical transformer design, wherein cross-attention layers compare the model-predicted vectors to the ground truth vectors of the training data. See @transformer-sec. Since we were not concerned with next-token prediction in @transformer-sec we opted not to use cross-attention layers and instead focus entirely on self-attention. See @cross-attention-digaram> for an illustration of the cross-attention mechanism.

However, there is a scenario in gravitational-wave data science for which a natural application of cross attention can be applied --- between the detector outputs of multiple interferometers of a gravitational-wave detection network. There are two ways in which we could deal with this scenario, we could apply the appropriate temporal encoding, and add an encoding element informing the model which detector the vector originated from, or we could simply use cross attention between the multiple detectors.

In cross-attention, query, key, and value vectors are still generated, but for two sequences instead of one. The query vectors from one sequence are then compared with the key vectors of the other sequence, and the value vectors of that sequence are summed together similarly to in self-attention. What this does is it allows the attention layer to accumulate information from the other sequence that is relevant to vectors in the first sequence, because the choice of which sequence will provide the query, and which key and value matters, cross-attention is not commutative. After calculating the cross-attention between detectors, you can then add this result back with the self-attention results, allowing you to accumulate relevant information both from other temporal locations in one detector and from information provided by other detectors. 

Overlapnet used both detectors as input since there was no need to try and optimise for low FAR. When attempting to improve on this network operation with attention layers, it is a natural choice to apply cross-attention.

#figure(
    image("cross_attention.png", width: 100%),
    caption: [Illustration of the action of a single cross-attention head. In contrast to a self-attention head, a cross-attention head takes two sequences as input: a querier sequence, and a queried sequence. The queryier sequence is converted into query vectors with a learned weights matrix, and the queried sequence is converted into key and value vectors. The rest of the attention mechanism functions identically to self-attention, but using this query, key, and value vectors that originate from different sources. For more details on the self-attention mechanism see the description in @sec-attention.]
) <cross-attention-digaram>

=== Autoencoders and Denoising <autoencoder-sec>

Autoencoders are a family of artificial neural network architectures, they can utalise many different layer types from pure dense layers, to convolutional layers, to attention-layers, but are defined fundamentally by their inputs and outputs and the shape of the data as it moves through the networks. The vanilla autoencoder can be described as a form of unsupervised learning since the model input is the same as the model output, and therefore, although it has in some sense a model label --- its input, the data does not need to be labeled, as it is its own label.

A vanilla autoencoder attempts to compress the information content of its input into a latent vector that is typically significantly smaller than the input vector, then regenerate the original input vector from that reduced latent vector with as little loss as possible. This has useful applications as a compression algorithm, but also sometimes in encryption and many other applications. Having access to a lower dimensional latent space that can represent elements of a unique distribution has many uses in generative models and classifiers. Many different subtypes of autoencoder try to regularise the latent space into a more useful format, the most common of which is the Variational AutoEncoder (VAE). 

Autoencoders can also be used for anomaly rejection which has application in gravitational-wave analysis in both glitch and burst detection. Because an autoendoer is trained to reconstruct data from a given distribution, if it is fed a result that lies outside that distribution this will likely result in a high reconstruction loss. The value of this loss then can be used to determine if the autoencoder has encountered something from outside its training distribution. In the case of gravitational-wave glitches, we can train a model on known glitch types or a single known glitch type, we can then reject glitches that the autoencoder can successfully reconstruct as specimines of known detector glitches. For anomaly detection, we can instead train the model to reconstruct a standard interferometer background, if the autoencoder fails to reconstruct a section of the background well, it could be an indication of the presence of an anomaly, which in some cases could be a gravitational wave burst, combined with anomalies from multiple detectors, this could lead to a confirmed burst detection once glitches have been ruled out.

An autoencoder has three parts, an encoder, a decoder, and a latent vector. See @autoencoder-diagrams. The encoder attempts to reduce the input vector into a smaller latent space vector. Performing a kind of dimensional reduction which hopefully preserves most of the information content of the input vector by representing it in a more efficient data format. In most distributions that are interesting, there is a significant structure that can be learned and used to compress the data. Similar to compression algorithms, if the input data is random and has no structure, there will not be a way to represent that data in a much more efficient way. The encoder commonly has an identical structure to the convolutional layers in a CNN, as a function to compress the input data down into smaller feature maps, which is an identical function to what we require from our encoder. Encoders can also be built with dense or attention layers, and share most of the benefits and drawbacks of these previously discussed.

As well as acting as unsupervised models, it is possible to use pseudo-autoencoders which have the same structure as autoencoders but are not autoencoders in the truest definition, to produce an output that is not the same as its input, but instead an altered version of the input. This can be used to transform the input in some way, for example adding a filter to an image or audio input, or it can be used to try and remove noise from the original image. This latter type is known as a *denoising autoencoder*, and it is what we will be using as part of our expanded crosswave architecture. Denoising autoencoders are no longer considered unsupervised models, as the labels must be denoised versions of the input vectors. During training, the autoencoder learns to extract important features from the input image but ignores the noise, as it is not present in the output label and would be unnecessary information to propagate through the model. There have been some attempts to apply denoising autoencoders to gravitational-wave data in order to remove interferometer noise and reveal hidden gravitational-wave signals.

#figure(
    grid(
        columns: 1,
        rows:    1,
        gutter: 1em,
        [ #image("dense_autoencoder.png", width: 80%) ],
        [ #image("convolutional_autoencoder.png", width: 100%) ]
    ),
    caption: [Illustration of two trivial autoencoder architectures, one using only dense layers, the other using convolutional layers. Both networks have very few neurons and would likely not see use in any real practical application but are presented for illustration only. Autoencoders consist of an encoder that performs dimensional reduction on an input vector to reduce its dimensionality to a smaller latent space and produce a latent vector, this latent vector is then processed by the decoder which attempts to perform the inverse operation and reconstruct the original input image, or a slightly altered version of the input, for example a denoised version of the original input. Often the decoder is simply an inversed version of the encoder, which introduces the concept of transposed convolutional layers which perform the inverted operation of convolutional layers. _Upper:_ Illustrative dense layer autoencoder with a two-layer encoder and a two-layer decoder. The latent space of this autoencoder has two dimensions meaning the dimensionality of the input vector has been reduced from five down to two _Lower:_ Illustrative convolutional autoencoder with a two-layer encoder consisting of convolutional layers and a two-layer decoder consisting of transposed convolutional layers. The latent vector of this autoencoder has four elements, which means there has only been a reduction of one element between the input vector and the latent space.]
) <autoencoder-diagrams>

== CrossWave Architecture

The CrossWave architecture is the most ambitious model architecture presented in this document. It attempts to combine many intuitions gained throughout the research, with contemporary network features that are known to work well in similar domains. We utilize several new conceptual elements, denoising autoencoder head, and cross-attention layers, which are described in more detail in @additional-elements.



#set page(
  flipped: true
)
#set align(center)
#image("crosswave_small_diagram_expanded.png",  width: 85%)
#figure(
    image("crosswave_large_diagram_expanded.png",  width: 96%),
    caption: [],
) <crosswave-large-diagram>
#set align(left)

#set page(
  flipped: false
)

=== Arrival Time Parameter Estimation

#figure(
    grid(
        columns: 2,
        rows:    1,
        gutter: 1em,
        [ #image("error_vs_arrival_time.png", width: 100%) ],
        [ #image("binary_arrival_time_difference.png", width: 100%) ]
    ),
    caption: []
) <crosswave_regression_scores>

#figure(
    grid(
        columns: 2,
        rows:    2,
        gutter: 1em,
        [ #image("h1_signal_a_arrival_time.png", width: 100%) ],
        [ #image("h1_signal_b_arrival_time.png", width: 100%) ],
        [ #image("l1_signal_a_arrival_time.png", width: 100%) ],
        [ #image("l1_signal_b_arrival_time.png", width: 100%) ],
    ),
    caption: []
) <crosswave_arrival_time_prediction_error>


=== Other Parameter Estimation Results

#figure(
    grid(
        columns: 2,
        rows:    2,
        gutter: 1em,
        [ #image("signal_a_mass_1.png", width: 100%) ],
        [ #image("signal_b_mass_1.png", width: 100%) ],
        [ #image("signal_a_mass_2.png", width: 100%) ],
        [ #image("signal_b_mass_2.png", width: 100%) ],
    ),
    caption: []
) <crosswave_mass_prediction_error>

#figure(
    grid(
        columns: 2,
        rows:    1,
        gutter: 1em,
        [ #image("signal_a_luminosity_distance.png", width: 100%) ],
        [ #image("signal_b_luminosity_distance.png", width: 100%) ],

    ),
    caption: []
) <crosswave_luminosity_distance_error>

#figure(
    grid(
        columns: 2,
        rows:    6,
        gutter: 1em,
        [ #image("signal_a_spin_1_x.png", width: 100%) ],
        [ #image("signal_b_spin_1_x.png", width: 100%) ],
        [ #image("signal_a_spin_1_y.png", width: 100%) ],
        [ #image("signal_b_spin_1_y.png", width: 100%) ],
        [ #image("signal_a_spin_1_z.png", width: 100%) ],
        [ #image("signal_b_spin_1_z.png", width: 100%) ],
        [ #image("signal_a_spin_2_x.png", width: 100%) ],
        [ #image("signal_b_spin_2_x.png", width: 100%) ],
        [ #image("signal_a_spin_2_y.png", width: 100%) ],
        [ #image("signal_b_spin_2_y.png", width: 100%) ],
        [ #image("signal_a_spin_2_z.png", width: 100%) ],
        [ #image("signal_b_spin_2_z.png", width: 100%) ],
    ),
    caption: []
) <crosswave_spin_error>



=== Physicallised Intuition
