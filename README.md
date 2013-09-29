# Code Kata

This is a code kata to explore interaction with third-party APIs with good testing practice.

# The project

Build a search interface that finds venues (from Foursquare), allowing user to mark some as "favourite", and retrieve those favourites later.

Product Requirements:

* User should be able to search for venues via the provided proxy and see their details.
* User should be able to mark and unmark a venue as a "favourite".
* User should be able to retrieve a list of their favourite venues.
* When searching, any venues previously marked as favourite should be indicated as such.

Improvements:

* Currently the favourite data is temporary stored in the client before it is saved. This may have security implications if the favourite data is modified to cause trouble to the system. This could be addressed by creating a temporary store on the server and passing only favourite IDs to the client.



