# TreeHacks 2019: Civic Engagement through Citizen X
### #hackwithtrees with Cliff Panos & Cal Stephens

### Become a Next-Generation Citizen. Use your voice to learn about your political sphere.

We wanted to design an innovative way to make the sharing of political information more accurate, transparent, and accessible with technology. We designed Citizen X to not only inform citizens about their representatives but also to engage them, start discussions, and inspire people to expand their knowledge about their political climates and connect them to other resources

<p align="center">
    <img src="Assets/Screenshots/London Breed.png" width=290px> <img src="Assets/Screenshots/National Query.png" width=290px> <img src="Assets/Screenshots/Set Location.png" width=290px>
</p>

<br></br>
<hr></hr>


## Inspiration
##### In the sphere of Awareness, we wanted to design an innovative way to make the diffusion and sharing of political information more accurate, transparent, and accessible through technology.
Common news sources implement ranking systems that create an echo chamber for opinions and even misinformation. We designed Citizen X to not only inform citizens about their representatives but also to engage them, foster discussions, and inspire them to expand their knowledge about their political climates by connecting them to further resources.

## What it does
##### Citizen X is building the next generation of informed citizens.
Our iOS app allows users to use their voice to ask about representatives on different scopes of focus, such as their local, state, and national legislators. Users can even learn about representatives in locations other than their own and be guided to sites and social media outlets where they can learn more. Citizen X is an information funnel that doesn't optimize for views or impressions; it tells the people what you want to know. 

## How we built it
##### Citizen X uses SoundHound's Houndify SDK and Phone2Action's Legislator Web API.
Citizen X uses technology to ease the process of diffusion while encouraging users to stay engaged through an interactive user experience. Through voice interactions with SoundHound, users enage and tell Citizen X what they want to learn about: many or a single legislator(s) as well as their area of interest. Citizen X uses this information to query Phone2Action's Legislator API to retrieve trusted overview information about representatives. Citizen X was built with Xcode in Swift for iOS 12.

## Challenges we ran into
##### Unfamiliar SDK and Web API territory + a complex view hierarchy.
Using the SDKs proved challenging at first, especially with regards to analyzing the phrases spoken to SoundHound as well as the parsing of the JSON retrieved from Phone2Action. Equally as difficult was building this information into a user interface that kept users encouraged, focused, and informed. We spent much of our time refining the stacking card layout, tuning the interface, and supporting the voice interaction history.

## Accomplishments that we're proud of
##### Citizen X improves people's political awareness in an unbiased and self-driven manner.
We love how Citizen X makes the user feel. Users feel like they're having a conversation about politics in order to better themselves. Additionally, because Citizen X links users to trusted sites of information such as Vote Smart and the Center for Responsive Politics, we've given citizens a way to learn without being subjected to algorithmic recommendations. People can start by learning about the representatives within their communities and then expand their scope of interest up to their state and nation.

## What we learned
##### Experience, experience, experience.
We learned how to present meaningful information and engage users in ways we had never had experience with before: voice chatting. Additionally, we gained lots of experience using an unfamiliar Web API and validating data and images retrieved from the web. Building the complex card stack layout put our UIKit knowledge to the test as well as our ability to create a fluid and memory-efficient interface.

## What's next for Citizen X
##### Support more advanced queries & ship Citizen X
We hope to future-proof the use of our voice chat API so that we can share Citizen X with the world. Alongside this, we hope to support more complex voice interactions and make different types of queries and information cards available.
