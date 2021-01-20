#pseudo-round-robin

A Nyquist macro for Audacity for producing synthetic variations of audio samples

This script was undertaken as an experiment in taking single samples and generating slightly perturbed variants of the sample, to attempt to give the illusion of more audio material for "round-robin" use in software samplers. 

(**Round-robin**: Contemporary samplers often use what is called the round-robin technique - several variants of the same sample for, commonly, each MIDI note and velocity region, are cycled through whenever a note is triggered, to give the musical sequence a subtle bit of variation. The cycle of variants goes back to the first sample when all the samples have been run through, to start again. Using this alongside other techniques, the goal is to attempt to give a sampler "performance" a bit of verisimilitude so it does not sound so much like "computer music." However, recording multiple samples of a single note, and doing that for all possible notes and for a few different velocity layers, requires a considerable investment in time and effort, and access to state of the art recording technology. Consequently, often we don't have sample sets with as much round-robin going on as we'd like.) 
 
To generate synthetic variations, differing from the original but not radically so, the technique of time scaling was considered, in order to temporally draw out or compress the time "envelope" of the note. In particular, varying the onset of a note in this way should make the most significant perceptual difference. But different variations on the source sample should be subtly altered and not too obviously "processed": the aim is to give the illusion of variety but not to have any member samples of the round-robin stand out too much. 

This script uses Audacity's built-in Sliding Stretch effect for the time scaling. The latest version of Audacity is required (I have 2.4.2 at the time of writing). The actual script, much more concise than this explanation, is the file PseudoRoundRobin.ny. To install and enable this as an Audacity plugin, follow the instructions for your platform at https://wiki.audacityteam.org/wiki/Download_Nyquist_Plug-ins#install

**Usage**: take a single audio sample of a monophonic, single note or "hit", topped and tailed of all initial and trailing silence. Ensure that it is the only file in a project. Select all audio in the file and run the script. It will ask you how many copies you want, and the maximum and minimum parameters for the initial time scale (numbers > 0% speed up the audio and < 0% slow it down, in the scheme used by the Sliding Stretch plugin). The script will choose a random amount to time scale the audio each time within the bounds set by the maximum and minimum parameters.

The option to make all newly generated samples preserve the length of the original sample is also available. 

The **micro-pitch variation** setting is for altering the pitch of the generated variants by a few cents if you so wish. Some instruments would have more natural micro-pitch variation than others as played "in the wild", e.g. unfretted string instruments would exhibit more variation than keyboard instruments, but only a tiny amount of detuning is recommended with any instrument samples; we are looking to make an auditory impression on a subliminal level. The script will alter the pitch of each generated new audio clip up or down by a random amount capped at the level set by the slider (up to 10 cents), if you don't want any such variation leave the slider at zero.

(You can also do micro-pitch variation in an SFZ sampler file by using the pitch_random opcode - https://sfzformat.com/opcodes/pitch_random - which will randomise the playback pitch in cents each time, by altering the playback speed rather than by phase vocoder or SBSMS.)

When you have generated an acceptable set of variants on a sample, go to **File > Export > Export Multiple** to save the lot, using the differentiation scheme of your choice under "Name Files."

For each file in the set, a window may pop up asking you to confirm or input metadata for the audio. You may want to turn this off if you haven't done so already. https://manual.audacityteam.org/man/metadata_editor.html#Suppress_the_metadata_dialog 

Supposing you now have a collection named, for example pianoC3_01.wav, pianoC3_02.wav, etc. The next step is to insert these into a sampler patch, making a round-robin set of samples for a MIDI note and maybe for a certain velocity layer or other constraint. How to do this depends on the specifics of your software sampler. 