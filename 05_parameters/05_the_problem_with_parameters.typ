#set page(numbering: "1", number-align: center)

= Dragonn: Exploring Deep Gravitational-Wave Classifier Hyperparameter Space with Genetic Algorithms <dragonn-sec>

#set math.equation(numbering: "(1)")

== The Problem with Parameters <hyperparameters-section>
\
An applicable machine-learning approach can be found for almost every problem in gravitational-wave data science @gw_machine_learning_review. That does not mean that machine learning should be applied to every problem in gravitational-wave data science. We must be careful with a liberal application of machine learning approaches and always keep the goal in mind: what exactly are we trying to achieve by applying this particular method? As described in the "No free lunch theorem" @no_free_lunch, for every possible algorithm, there are advantages and disadvantages, and there is no algorithm that completely supersedes another in all classes. This means a rigorous and systematic method for comparing different techniques is required. This problem is confounded with deep learning techniques, as the number of free parameters when designing and optimising your neural network is vast --- technically infinite in the non-real case where network size is not a constraint. 

There are a huge number of adaptations that can be applied to a network @architecture_review @deep_learning_review @conv_review @attention_is_all_you_need, and the number of developed layer types and general architectures is considerable and increasing in an almost exponential fashion year on year @exponential_growth. Even ignoring the number of different types of network modifications, most modifications have multiple associated parameters, including parameters specifying the design of individual network layers @cnn_review @attention_is_all_you_need @dropout_ref @batch_normalisation_ref. We label any parameter to do with the model design or any parameter that is not optimized during the model training process as a *hyperparameter* @hyperparameter_optimisation_review @cnn_hyperparameters.

Hyperparameters include values to do with the greater structure of the network, such as the type and number of layers in a network, the configuration of the layers themselves, such as the number of neurons in a dense layer, or the number of filters in the convolutional layer; the training of the network, such as the learning rate, the number of epochs, and the optimiser; as well as all the parameters associated with the training dataset @hyperparameter_optimisation_review @cnn_hyperparameters. Essentially, hyperparameters encompass all parameters that must be determined before the initiation of model training.

This chapter will first give a brief overview of available hyperparameter optimisation methods, then discuss why evolutionary population-based methods were chosen as the hyperparameter optimisation technique of choice, followed by a demonstration of the effectiveness of hyperparameter optimisation to improve model performance on various gravitational-wave data analysis problems. We will conclude by discussing how this work has been pivotal in developing MLy @MLy, a machine learning pipeline currently preparing for live deployment in the latter half of the fourth joint observing run.

The goal of any given hyperparameter optimisation process is to maximise the model's performance given a specific objective function @hyperparameter_optimisation_review @cnn_hyperparameters. This objective function could be as simple as minimising the model loss, but other performance metrics might also be important to us, such as model inference time or memory usage --- or, as is the case for gravitational wave transient detection, minimising values that it would not necessarily make sense to have as part of the loss function, like False Alarm Rate (FAR) @false_alarm_rate_ref. If we naively gave models a loss function that only allows a once-in-one-hundred-years FAR, they might never produce a positive result at all @false_alarm_rate_ref. It would be hard to balance such a low FAR requirement with other terms in the loss function, and balancing loss function terms is always a difficult challenge that leads to unstable training.

If one is to compare two different sets of architectures, for example, comparing fully connected networks @perceptron_and_neural_network_chapter to networks with some convolutional layers @deep_learning_review @conv_review, a method must be used to determine all of these hyperparameters. Many, if not most, of these hyperparameters, will have some effect, somewhere between significant and small, on the model's overall performance @hyperparameters_model_performance. Thus, just like the tunable parameters of the model itself, the vector space defined by these hyperparameters comprises regions of different model performances, and indeed model performance can be measured in multiple ways. Presumably, given the task at hand, there will be some region within this parameter space that maximises desired performance goals. In the optimal scenario, the comparison of two sets of architectures and hyperparameters will occur between these regions. Thus, a method must find approximate values for these optimal hyperparameters. 

We might now see the recursion that has started here. We are applying an optimisation method to an optimisation that will introduce its own set of hyperparameters. Such hyperparameters will, in turn, need to be at least selected if not optimised. However, it can be shown that the selection of network hyperparameters can make a profound impact @hyperparameters_model_performance on the performance of the model, and it is hoped that with each optimisation layer, the effects are considerably diminished, meaning that roughly tuned hyperparameters for the hyperparameter optimiser are sufficient for to find comparably optimised solutions.

We can use a similar example parameter space that we generated for @gradient-descent-sec, except this time it is being used to represent the hyperparameter space against the model-objective function, rather than parameter space against the model loss. See @hyperparameter_space.

#figure(
    image("hyperparameter_space.png",  width: 90%), 
    caption: [An example arbitrary hyperparameter space generated from a random mixture of Gaussians. The space presented here is 2D. In actuality, the space is likely to have a much larger dimensionality. Unlike in gradient descent where we are trying to minimize our loss, here we are trying to maximize our objective function, whatever we have determined that to be.]
) <hyperparameter_space>

Perhaps unsurprisingly, hyperparameter optimisation is an area of considerable investigation and research in machine learning @hyperparameter_optimisation_review. However, similar to the rest of the field, it would be incorrect to call it well-understood. Whilst there are several effective methods for hyperparameter optimisation, there is no universally accepted set of criteria for which method to use for which problems. What follows is a brief non-comprehensive review of currently available hyperparameter optimisation techniques.

=== Human-guided trial and error

The most straightforward and obvious method to find effective model hyperparameters relies on human-guided trial and error. This method, as might be expected, involves a human using their prior assumptions about the nature of the problem, the dataset, and the model structure, to roughly guide them towards an acceptable solution, using multiple trials to rule out ineffective combinations and compare the results to the human's hypothesised intuitions. Evidently, whilst this technique is simple to implement and can be time efficient, it suffers from several deficiencies. The results of this method can vary in effectiveness depending on the previous experience of the guiding human; if they have a lot of experience with prior optimisation tasks, they are likely to have more effectively tuned priors. It is also possible that an experienced optimiser might have overly tuned priors, and that bias might cause them to miss possible new solutions that were either previously overlooked or are only relevant to the particular problem being analysed. The results of this method also suffer from a lack of consistency; even the most experienced human optimiser is unlikely to perform precisely the same optimisation technique across multiple problems. Despite these weaknesses, this method is commonly used throughout gravitational wave machine-learning papers @gabbard_messenger_cnn @george_huerta_cnn and can still be an effective solution for isolated optimisation.

=== Grid Search

A more methodical approach is to perform a grid search across the entirety or a specified subsection of the available parameter space @hyperparameter_optimisation_review. In this method, a grid of evenly spaced points is distributed across the selected parameter space - a trial is performed at each grid point, and the performance results of those trials are then evaluated. Depending on the computing power and time available, this process can be recursed between high-performing points. This method has the advantage of performing a much more rigorous search over the entirety of the parameter space. However, it can be highly computationally expensive if your parameter space has large dimensionality, which is often the case. A grid search can also be ineffective at finding an optimal solution if the objective function is non-linear and highly variable with minor changes or evidently, if its solution lies outside of the range of initial boundaries. See @grid_search for an example grid search.

#figure(
    image("grid_search.png",  width: 90%), 
    caption: [ An example of the samples a grid search might use to find an optimal hyperparameter solution.]
) <grid_search>

=== Random Search

Random search is a very similar method to a grid search; however, instead of selecting grid points evenly spaced across the parameter space, it randomly selects points from the entirety of the parameter space @hyperparameter_optimisation_review. It has similar advantages and disadvantages to grid search, and with infinite computing resources, both would converge on the ground truth value for the objective function. However, random search has some benefits over grid search that allow it to more efficiently search the parameter space with fewer evaluations. When performing a grid search, the separation of grid points is a user-defined parameter, which both introduces a free parameter and creates possible dimensional bias. A grid search will also search the same value for any given hyperparameter many times, as along the grid axis, it will appear many times, whereas a random search should rarely repeat samples on any hyperparameter. It should also be noted that some statistical uncertainty will be introduced, which would not be present in the case of a grid search and might limit the comparability of different approaches. Both the random and grid search techniques have the disadvantage that all samples are independently drawn, and unless the processes are recursed, no information from the performance results can influence the selection of new points. See @random_search.

#figure(
    image("random_search.png",  width: 90%), 
    caption: [ An example of the samples a random search might use to find an optimal hyperparameter solution.]
) <random_search>

=== Bayesian Optimisation

A Bayesian optimisation approach makes use of our initial beliefs, priors, about the structure of the objective function @hyperparameter_optimisation_review. For example, you might expect the objective function to be continuous and that closer points in the parameter space might have similar performance. 
The objective function is estimated probabilistically across the parameter space. It is updated as more information is gathered by new samples, which can be gathered either in batches or one at a time. The information obtained by these new samples is incorporated into the estimated objective function in an effort to move it closer to the ground truth objective function. 

The placement of samples is determined by a combination of the updated belief and a defined acquisition function, which determines the trade-off between exploration and exploitation. The acquisition function assigns each point in the parameter space a score based on its expected contribution to the optimisation goal, effectively directing the search process. A standard method for modelling the objective function in Bayesian optimisation is Gaussian Processes, but other techniques are available, such as Random Forests and Bayesian Neural Networks, among others. This optimisation technique is often employed when evaluating the objective function is expensive or time-consuming, as it aims to find the optimal solution with as few evaluations as possible. See @bayesian_descent_hp_optimisation.

#figure(
    image("bayesian_descent.png",  width: 90%), 
    caption: [ An example of the samples a Bayesian optimization might use to find an optimal hyperparameter solution. The descent method shown here has used a Gaussian Process to attempt to find the objective function maximum but has not done so particularly successfully. The method was not tuned to try and increase performance, as it was just for illustratory purposes.]
) <bayesian_descent_hp_optimisation>

=== Gradient-Based Optimisation

In some rare cases, it is possible to find optimal model hyperparameters using a similar method to the one we used to determine model parameters during model training @hyperparameter_optimisation_review. We can treat the hyperparameter space as a surface and perform gradient-descent (or this ascent, which has the same principles but in reverse). Since gradient descent was already discussed in some detail in @gradient-descent-sec we will not repeat ourselves here. The advantage of gradient-based optimisation is that it can utilize extremely powerful gradient descent mechanisms that we have seen are potent optimisiers. The major disadvantage, however, is that for most hyperparameters, it is not possible to calculate the gradient. There are workarounds in some specific scenarios and much research has gone into making gradients available, but such work is still in early development and not applicable in many scenarios, thus we limit our discussion to this paragraph.

=== Population-Based Methods

The final category of hyperparameter optimization methods that we will discuss, and the one that we have chosen to employ in our search for more optimal classifiers, are population-based methods @hyperparameter_optimisation_review_2. These come in a variety of different subtypes, most prominent of which perhaps are evolution-based methods, such as genetic algorithms. Population-based methods are any methods that trial several solutions before iterating, or iterate several solutions in parallel, as opposed to trialing one solution, and then iterating the next solution on the results of the previous. Technically, since they trial a number of solutions before iteration, both random and grid searches could be considered population-based methods with only one step, although they are not usually included. Since we have chosen to adopt a method from this group, will will review some of the subtypes.

==== Genetic Algorithms

For our hyperparameter search, we have chosen to implement genetic algorithms, a population-based evolutionary method @genetic_algotrithm_review @hyperparameter_optimisation_review @hyperparameter_optimisation_review_2. Genetic algorithms are inspired by the principle of survival of the fittest found in nature within Darwinian evolution @genetic_algotrithm_review. They require the ability to list and freely manipulate the parameters we wish to optimize (in our case our hyperparameters) --- continuing with the biological analogy these parameters are a given solutions genes, $g_i$ the full set of which is a solution genome $G_i$. We must also be able to test any genome and how well a solution is generated with that genome satisfies our objective function, we must be able to condense these measurements into a single performance metric --- the fitness of that solution. Any optimization problem that fits these wide criteria can be attempted with genetic algorithms, meaning they are a very flexible optimization solution. Our problem the hyperparameter optimization of deep learning models fits both criteria, thus it is an applicable choice for the task. 

Initially, a number of genomes, $N$, are randomly generated within predefined parameter space limits @genetic_algotrithm_review. All possible gene combinations must produce a viable genome or a mechanism must be in place to return a fitness function of zero if a solution is attempted with an invalid genome. A solution (in our case, a model) is generated for each of the $N$ genomes, this forms your population. Every member of the population is trialed (in our case, the model is trained) either sequentially or in parallel depending on your computational resources and the scope of the problem. In the basic genetic algorithm case, each trial within a generation is independent and cannot affect another member of the population until the next generation, and validated (the model is validated) in order to produce a fitness function. This process of generating a set of genomes that defines a population of solutions, and then testing each member of the population to measure its effectiveness is known as a generation. Multiple generations will be iterated through, but each generation after the first is based on the fitnesses and the genomes of the previous generation, rather than just being randomly generated as in the first generation. Genes and gene combinations that are found in highly-scoring members of the population are more likely to be selected for use in the next generation. After the algorithm has run for a number of generations, possibly determined by some cut-off metric, in theory, you should have produced a very highly-scoring population. You can then select the best-performing model from the entirety of your evolutionary history.

It is the selection process between generations that gives the genetic algorithm its optimising power @genetic_algotrithm_review, rather than grid or random methods, each generation uses information from the previous generation to guide the current generation's trials. There are multiple slightly different variations, we use one of the most common techniques, which is described in more detail in @dragonn-method. 

As mentioned genetic algorithms are very flexible, they can be applied to a wide variety of optimization problems @genetic_algotrithm_review, they can handle almost any objective function and operate in any kind of parameter space, including discrete, continuous, or mixed search spaces @genetic_algotrithm_review. They are also quite robust, unlike many optimization solutions which, sometimes rapidly, single out a small area of the parameter space for searching, genetic algorithms perform a more global search over the parameter space. Despite these advantages, they have the large disadvantage of requiring a large number of trials before converging on a high-performing solution, for this reason, they are less often used for hyperparameter optimization as each trial requires model training and validation @hyperparameter_optimisation_review_2.

==== Particle Swarm Optimisation

For completion, we will also discuss several other optimization techniques. One of which is particle swarm optimization, which is inspired by the emergent behavior found in swarms of insects, flocks of birds, and schools of fish @hyperparameter_optimisation_review_2. Seemingly without coordination or central intelligence, large numbers of individually acting agents can arrive a a solution to a problem using information from their nearest neighbours @flocks.

In Particle Swarm optimisation, akin to genetic algorithms, an initial population is randomly generated and trialed. In this case, each member of the population is called a particle, forming the elments of a swarm. Rather than waiting for the end of each generation in order to update the parameters of each solution, each solution is given a parameter-space velocity which is periodically, or continuously updated by the performance of the other members of the population. Some variations aim to imitate real animal swarms more closely by limiting each particle's knowledge to certain regions or to improve convergence rates by weighting some particles more highly than others @hyperparameter_optimisation_review_2.

Particle swarms can have much quicker convergence than genetic algorithms, due to the continual updates to their trajectory in parameter space. However, effective employment of particle swarms requires that your solutions can adjust their parameters quickly, which is not the case for many deep learning hyperparameters, most prominently structural hyperparameters which would often require retraining the model from scratch after only small changes. 

==== Differential Evolution

Like genetic algorithms, differential evolution methods are a form of evolutionary algorithm, but rather than generating a new population based on a selection of genes from the previous generation, it instead generates new parameters based on differentials between current solutions @hyperparameter_optimisation_review_2 @differential_evoloution. This means that genes in the current generation are not necessarily anything like genomes in the previous generation --- parameters are treated in a vector-like manner rather than discreetly.

Differential Evolution can work well for continuous parameter spaces, and shares many of the advantages of genetic algorithms as well as sometimes converging more quickly, however, it deals less well with discrete parameters than genetic algorithms and is less well studied, so understanding of their operation is not as well developed @differential_evoloution.

== Dragon Method <dragonn-method>

=== Why genetic algorithms?

Genetic Algorithms are optimisation methods that can be used to find a set of input parameters which maximise a given fitness function. Often, this fitness function measures the performance of a certain process. In our case the process being measured is the training and testing of a given set of ANN hyperparameters - the hyperparameters then, are the input parameters which are being optimised.

#figure(
    table(
        columns: (auto, auto, auto),
        ["Hyperparameters (genes)"], [], [],
        ["Base Genes (1 each per genome)], [], [],
        ["Name", "Min", "Max"], [], [],
        ["Structural"], [], [],
        ["Num Layers (int)"], [], [],
        ["Input Alignment Type (enum)"], [], [],
        ["Training"],  [], [],
        ["Loss Type (enum)"], [], [],
        ["Optimiser Type (enum)"], [], [],
        ["Learning Rate (double)"], [], [],
        ["Batch Size (int)"], [], [],
        ["Num Epocs (int)"], [], [],
        ["Num Semesters (int)"], [], [],
        ["Dataset"], [], [],
        ["Num Training Examples (int)"], [], [],
        ["Layer Genes (1 each per layer per genome)"], [], [],
        ["Name", "Min", "Max"],
        ["Layer Type (enum)"], [], [],
        ["Dense"], [], [],
        ["Number of Dense ANs (int)"], [], [],
        ["Convolutional"], [], [],
        ["Number of Kernels (int)"], [], [],
        ["Kernel Size (int)"], [], [],
        ["Kernel Stride (int)"], [], [],
        ["Kernel Dilation (int)"], [], [],
        ["Pooling"], [], [],
        ["Pooling Present (bool)"], [], [],
        ["Pooling Type (enum)"], [], [],
        ["Pooling Size (int)"], [], [],
        ["Pooling Stride (int)"], [], [],
        ["Batch Norm"], [], [],
        ["Batch Norm Present (bool)"], [], [],
        ["Dropout"], [], [],
        ["DropOut Used (bool)"], [], [],
        ["DropOut Value (double)"], [], [],
        ["Activation"], [], [],
        ["Activation Present (bool)"], [], [],
        ["Activation Function (enum)"], [], [],
    ),
    caption: []
) <table-of-hyperparameters>

Optimised parameters are called genes ($ g $), and each set of genes is called a genome *genomes* ($G$). $G = [g_1, g_i ... g_{x}]$, where $x$ is the number of input parameters. Each genome should map to a single fitness score ($F$) via the fitness function.

Genetic algorithms operate under the following steps, note that this describes the procedure as performed in this paper, slight variations on the method are common:

+ *Generation:* First, an initial population of genomes, $P$ is generated. $P = [G_1, G_i, ... G_N]$, where $N$ is the number of genomes in the population. Each genome is randomised, with each gene limited within a search space defined by $g_{i}{min}$ and $g_{i}{max}$.
+ *Evaluation:* Next, each genome is evaluated by the fitness function to produce an initial fitness score. In our case this means that each genome is used to construct a CNN model which is trained and tested. The result of each test is used to generate a fitness score for that genome.
+ *Selection:* These fitness scores are used to select which genomes will continue to the next generation. There are a few methods for doing this, however since we do not expect to need any special functionality in this area we have used the most common selection function - "the Roulette Wheel" method. In this method the fitness scores are normalised so that the sum of the scores is unity. Then the fitness scores are stacked into bins with each bin width determined by that genomes fitness score. $N$ random numbers between 0 and 1 are generated, each genome is selected by the number of random numbers that fall into its bin. Any given genome can be selected multiple or zero times.
+ *Crossover and Mutation:* The genomes that have been selected are then acted upon by two genetic operators, crossover and mutation. Firstly, genomes are randomly paired into groups of two, then two new genomes are created by randomly selecting genes from each parent. A bit-wise mutation is then performed on each of the new genomes with a certain mutation probability $M$. Mutation and Crossover creates genomes which are similar to both parents but with enough differences to continue exploring the domain space.
+ *Termination:* If the desired number of generations has been reached the process ends and the highest performing solution is returned. Else-wise the process loops back to step 2 and the newly created genomes are evaluated.

== Example Data

Three sets of data were independently generated using identical parameters but differing random seeds - training, testing, and validation datasets. The training and testing datasets were used during the training of each model during each generation. The same datasets were used for each genome - however each was independently shuffled with a different seed for every case.

The datasets parameters were chosen to match as closely as possible, the following paper by 

SNR - discussion - range vs single value, high snr vs low snr




== Layer Configuration Tests
Testing which combinations of layers are most effective.

=== Dense Layers

=== Convolutional Layers <cnn_sec>

=== Regularisation

=== Custom Layer Exploration

== Input Configuration Tests <input-configuration-sec>
Testing which input method is most effective. I.e. number of detectors and widthwise, lengthwise, or depthwise.

One detector vs multiple.

SNR cutoff point.


=== Noise Type Tests <noise-type-test-sec>
Also, noise type.

And feature engineering.

== Output Configuration Tests

Baysian tests

== Label Configuration Tests
Testing which configuration of the label is the most effective combination of noise, glitch, etc.

== Branched Exploration

== All together

== Deployment in MLy <deployment-in-mly>

#figure(
    image("mly_coincidence_diagram.png",  width: 75%), 
    caption: [MLy Coincidence Model developed with Dragonn @MLy. ]
) <mly_coincidence>


#figure(
    image("mly_coherence_diagram.png",  width: 100%), 
    caption: [MLy Coherence Model developed with Dragonn @MLy. ]
) <mly_cohernece>


