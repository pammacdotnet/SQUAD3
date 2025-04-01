#set text(lang: "en")
#set page(width: 15cm, height: auto, margin: 1cm)
#set par(justify: true)

= Abstract
Alzheimer's disease (AD) is a type of mental decay affecting over 50M of people. Recent discoveries have linked Alzheimer and nocturnal habits. In this work, we objectively and unobtrusively monitor the nightly activity patterns of 166 people affected (and accordingly diagnosed) with AD for 3 days in a row. A companion control cohort of 116 healthy individuals is also compiled. All participants were nursing home residents. Sleep tracking was carried out with scientific-range wristband-shaped inertial sensors (actigraphs). Due to compliance with regulations required by clinical trials, an edge computing-based perspective is chosen. Within this approach, time series associated to bedtime gestures are offline recorded in internal memory units. Next, only deep sleep-linked acceleration streams are copied…

= Connection between Alzheimer's disease and sleep
Alzheimer's disease (AD) is a neurodegenerative process caused by the accumulation of $beta$-amyloids and tau proteins in the brain. In a healthy individual, these substances are naturally produced during the day as a defense mechanism but are recycled during deep sleep, restoring balance.
However, in an AD patient, the $beta$ + $tau$ tandem inadvertently forms aggregates, eventually collapsing synapses.


AD currently affects ~50 million people in developed countries @Norton14. Despite decades of (to some extent, fruitful) research @Dubois16, we still do not have a treatment/cure for it. Although there are several theories about its origin, AD is known to be closely related to the massive abnormal accumulation of the substance known as amyloid beta (A-$beta$) in the brain. Structures with this product are naturally produced by the body. However, if they are not properly cleaned away, they end up forming sticky plaques that eventually eclipse the synapses. Over time, this accumulation may reach a tipping point in which cellular damage takes place with functional and irreversible consequences. To make things worse, a crucial neurotransport protein called protein tau ($tau$-P) subsequently enters to scene becoming hyper-phosphorylated and forming tangles that further contribute to the biological destruction of neural networks.

Given the current lack of treatment for AD, the best strategy to counteract the condition is prevention. Sadly, it is very difficult to identify who is going to eventually develop this disease. Experience tells us that it very likely starts with a process known as amnestic mild cognitive impairment (AMCI). This is the stage between the expected cognitive decline of normal aging and a more serious mental deterioration (like that caused by AD). It is mainly characterized by casual short-term memory loss episodes that may increase in relevance/frequency. Within this phase, a person is still at nearly the max brainpower (except for annoying occasional bouts of forgetfulness). Nevertheless, AMCI can also be understood as a clinically profitable stage in which it may be possible to foresee the eventual advent of AD. In this period, science is still on time to trigger the implementation of available therapies that foster the so called cognitive reserve. In other words, AMCI represents a right time to act and as a not-to-be-missed opportunity to detect AD. Aside AMCI, the most representative phases of Alzheimer are summarized in @evolution.

#figure(
  image("adevol2.drawio.svg"),
  caption: [Evolution from AMCI to Severe AD, including development time,
    affected regions and most aggressive symptoms.],
) <evolution>

Sleep science and Neurology have recently achieved remarkable contributions to the understanding of the link between AD and sleep @Iliff12 @Xie13. From an endocrinological perspective, the lymphatic and glymphatic systems seem to act as a cleansing mechanism for the brain. Most importantly, these purification pipelines and channels seem to work at full steam only during sleep. A graphical summary of this chicken-and-the-egg causal chain of events that may take part in the Alzheimer/sleep interplay is shown in [fig:adloop]. These recent findings have made it very hard for the scientific community to escape the conclusion that there is a tight connection between sleep patterns and the dawning (and development) of an AD case. In other words, the pathological states that go from sleep degradation to a potential AD scenario represent, in turn, a system of positive feedback loop @Doig18. This neuronal physical-chemical circuit ends up leading to the pseudo-exponential amplified cascade of the initial perturbation.

#figure(
  image("adloop.svg"),
  caption: [Theorized pathway (and associated positive feedback loop) between deficient (fragmented) sleep and Alzheimer's],
) <loop>


The approach presented in this work also demonstrates how it is possible to monitor quietly and discretely sleep in large cohorts. These groups of participants are partly made up of cognitively impaired (AD-grounded dementia) and healthy people.


= Sleep monitoring in AD with inertial sensors
Our implementation is based on the use of inertial sensors to track the patient's movements during the night. The underlying hardware is a comfortable wristband that continuously records accelerations, storing data (packed 32-bit values) on an SSD at a frequency of 50 Hz. Monitoring is performed without requiring connection to the power grid or the Internet, reinforcing the premise of privacy protection. Sleep periods are then estimated using the algorithm described in @Borazio14.

During the research, sleep was monitored over several nights. To distinguish sleep periods from wakefulness, a low-pass filter is used, consisting of a sliding window (with threshold $k$) that identifies stillness events $Q S(t)$ of 1 second and labels them using the expression:

$Q S(t) = 1 quad forall quad k quad arrow.long.r quad k^2 > (f - 1)^(-1) times sum_(i = 1)^f (a_(x, y, z) - overline(a_(x, y, z)))^2 , quad "otherwise", med Q S ( t ) = 0$

Subsequently, all events with ($Q S(t) = 1$) are summed. Only the $i$ blocks lasting more than 10 minutes are labeled as deep sleep segments using $D S_i = [upright(l e n) (Q S ( t  = 1 ) > 600 med upright(s)]$, corresponding to Iverson's formula
(1 if true, 0 if false).

From any sleep monitoring session based on actigraphic hardware, it is immediate to distill the basic/fundamental parameters listed in @sleep-params.

#figure(
  align(center)[#table(
      columns: 2,
      align: (center, center),
      table.header(
        table.cell(align: center)[#strong[Sleep
            measure];],
        table.cell(align: center)[#strong[Definition];],
      ),
      table.hline(),
      [Initial in-Bed Time (IiBT)], [Time when patient goes to bed
        initially],
      [Final out-of-Bed Time (FoBT)], [Time when patient leaves bed
        definitely],
      [Time out-of-Bed (ToB)], [Total time out of bed from IiBT to FoBT],
      [Total Recording Time (TRT)], [FoBT - IiBT],
      [Sleep onSet (SoS)], [Time when first sleep starts],
      [Final Sleep Time (FST)], [Time when last sleep finishes],
      [Sleep onSet Latency (SoSL)], [Time taken to fall asleep (at any
        time)],
      [Sleep Period (SP)], [Sleep time between two awakenings],
      [Awake Period (AWP)], [Time awaken between two sleep periods],
    )],
  kind: table,
  caption: "Fundamental/direct parameters in sleep monitoring.",
) <sleep-params>


People affected by AD (even at very early stages and even before being officially diagnosed) often feel disoriented and may therefore exhibit some degree of hostility. Daily informal reports by relatives and health professionals support this claim, as well as formal studies @Gallagher11, @Mussele13. For these reasons, there are very few research works that apply actigraphy hardware to the analysis of dementia. Perhaps the only studies related to inertial sleep monitoring in people suffering from dementia are

For instance, in both @Andre19 and @Corbi22, researchers suggest an interplay of modern, unobtrusive hardware as the perfect tool for sleep monitoring in adverse settings. The simplicity of these systems makes them ideal for massive use in longitudinal and cross-sectional studies. With more detail, in @Andre19, a MotionWatch 8 wrist-worn triaxial device is used. This piece of equipment just records actigraphic data from cut-points applied to the activity counts throughout the daytime. The information is stored in an on-board memory for several days and is later read out and analyzed with special software (MotionWare). In the approach followed by @Corbi22, the system measures and stores raw acceleration. From these streams, periods of deep sleep and waking periods can be computed @Borazio14 and statistically representative values can be subsequently derived (@derived).


#figure(
  align(center)[#table(
      columns: (1fr, 1fr, 1.1fr),
      align: (left, left, center),
      table.header([#strong[Parameter];], [#strong[Definition];], [#strong[Formula];]),
      table.hline(),
      [Time in Bed (TiB)], [Total time in bed], [FoBT - IiBT - ToB],
      [Total Sleep Time (TST)], [Amount of time the patient sleeps during
        TiB], [$sum_(i = 1)^(\# thin upright(o f thin S P)) upright(S) upright(P)_i$],
      [First Sleep to Last Wake up Time (FStLWT)], [Time between the first
        sleep and the last sleep], [SoS - FST],
      [Wake After Sleep onSet (WASoS)], [Wake time between IiBT and
        FoBT], [FStLWT - TST],
      [Total Wake Time (TWT)], [All wake time throughout TiB], [ISL +
        WASoS],
      [Mean Sleep Latency (MSL)], [Arithmetic average of sleep
        latencies], [$frac(1, \# thin upright(o f thin S L)) sum_(i = 1)^(\# thin upright(o f thin S L)) upright(S) upright(L)_i$],
      [Sleep Efficiency (SE)], [Percentage of sleep of the total time in
        bed], [(TST/TRT) 100],
      [Number of Awakenings (AWK)], [Number of awaken events], [\# of
        $upright(A W P)$],
      [Mean Awakening Length (MAL)], [Arithmetic average of awake
        periods], [$frac(1, \# thin upright(o f thin A W P)) sum_(i = 1)^(\# thin upright(o f thin A W P)) upright(A W P)_i$],
      [Awakening Index (AWI)], [Number of awakenings per unit of
        time], [$upright(A W K) / upright(T S T)$],
      [Time to Get up (TtGu)], [Time after the last sleep until the end of
        the interval], [FoBT - FST],
    )],
  kind: table,
  caption: "Derived parameters in sleep monitoring.",
) <derived>


= Cohort selection

Gathering sleep data is the first and most critical phase of our setup. It was important to build a large and committed cohort of volunteers (or their relatives/legal tutors, in the case of demented participants). The composition of this group had also to maximize heterogeneity regarding the possible mental health aftermaths of the participants. This phase also implied transversally monitoring the sleep periods of mild cognitive impaired seniors, regardless of their age, gender, cultural level, ethnicity, and social background. Of course, these data were anonymized and logged for the sake of completeness, as well. Besides, all participants (or their corresponding tutors) filled-in and signed and informed consent form (@ax3-shipment) whose format and contents were agreed between the researchers' host institution and each external collaborator (retirement home).


Volunteers were recruited with the kind and agreed participation of relatives, neurologists, medical centres, and mental stimulation institutions. Each partaker was examined by one of the aforementioned specialists who issued a mental status-related diagnosis. As stated in [sec:intro], a total of 166 AD-affected and 116 healthy people were randomly selected and identified. The participants (and/or their caretakers) were also requested to keep a simple sleep diary in order to determine parameters such as IiBT and FoBT (described in @sleep-params).

#figure(
  image("ax3.png", width: 80%),
  caption: [Shipment of the AX3 wristbands and how they were used during the field research.],
) <ax3-shipment>

= Data retrieval

As stated in [sec:sleepparams], the chosen actigraphic device is the AX3 (Axivity, Ltd., Newcastle upon Tyne, UK). This powerful piece of equipment is a low-cost CE approved logging 3-axis accelerometer. The AX3 ([fig:ax3]-left) can measure accelerations up to 16 multiples of g and with a frequency up to 3200 Hz. However, a combination of 50 Hz rate and ± g was chosen for our purposes. Data were also stored in a packed way (18 bits, instead of 24), which made this device appropriate for long-term monitoring and less bothersome for caregivers (no need on their side to continuously worry about storage or battery). The sensor uses a non-volatile flash memory chip and is accessible through a USB-enabled micro-controller.

The device is suitable for use in a variety of environments (it is even water resistant up to 1.5 m). Accelerations outside the selected dynamic range result in saturation (clipping) of the recorded acceleration. The dynamic range of the accelerometer has no effect on the battery life or memory constraints. The AX3 logs time series internally in a binary-packed format (@stream-example). This format is named continuous-wave accelerometer format (CWA) and is very efficient for storing large amounts of data. Its specification is free and there exist implementations for many data processing frameworks @Ladha12, although the use of the default software, OmGui v43 is recommended. The AX3 also has a built-in, real-time clock and calendar, which provides the time base for the recorded acceleration data.

#figure(
  image("stream example.svg", width: 80%),
  caption: [Awake events for a night (gray areas surrounded by sleep periods) as detected by the ESS algorithm @Borazio14. The plot represents the acceleration streams associated to each axis of the AX3 sensor.],
) <stream-example>


A total of ten AX3 devices are used. Each sensor is preassigned to a specific sub-cohort according to their known cognitive status, gender, and age-range (@ax3).



#figure(
  align(center)[#table(
      columns: 4,
      align: (center, center, center, center),
      [#strong[AX3 Serial \#];], [#strong[Target AD
          status];], [#strong[Gender];], [#strong[Age range (years)];],
      [48684], table.cell(rowspan: 5)[AD], table.cell(rowspan: 3)[Women], [60
        \- 70],
      [42825], [70 - 80],
      [31434], [80 - 90],
      [3-4 44086], table.cell(rowspan: 2)[Men], [60 - 75],
      [48942], [75 - 90],
      [41168], table.cell(rowspan: 5)[Healthy], table.cell(rowspan: 3)[Women], [60
        \- 70],
      [37980], [70 - 80],
      [42984], [80 - 90],
      [3-4 45001], table.cell(rowspan: 2)[Men], [60 - 75],
      [32420], [75 - 90],
    )],
  kind: table,
  caption: "AX3 inertial devices used in this research (by serial number) and their association to specific groups of participants according to their AD status, sex, and age range.",
) <ax3>
#bibliography("squad.bib")
