# Zelus APIs

## What is Zelus 

Zelus is a part of the [Sinar Project](http://sinarproject.org). Sinar Project is a collection of related open source projects which consists of open data providers as well as applications that make information accessible to Malaysian citizens.

Zelus is a re-write of the earlier Kratos project, in [Sinatra](http://www.sinatrarb.com). Zelus provides data on Members of Parliament (MP), ADUN and Council Members in Malaysia, including what they stand for, whay their policies are and how to contact them. The primary service that Zelus provides is a set of APIs that other projects and applications are able to extract information on. The target users of Zelus are software applications!

The primary API endpoint for Zelus is:

    http://zelus.herokuapp.com

Zelus is a work in progress! 


## Overview

There are 2 types of requests to the Zelus APIs:

* HTTP GET - not authenticated, used to retrieve data only
* HTTP POST - authenticated by an API key, used to create or update records in Zelus

Generally to get data from Zelus, you will do something like the following:

    GET /person/<uuid>

GET requests are not authenticated but you can optionally attach the API key in order to allow us to track usage by your application. A sample application is provided at https://github.com/Sinar/Zelus-Sample.

## Main concepts

### Entities

There are a number of entities within Zelus.

#### User

An account in Zelus. Each user account has an API key, which is essential to creating records in Zelus.

#### Person

A human being. This is the base entity for a representative.

#### Representative

A Member of Parliament, ADUN or Council Member, generally anyone who is elected by and represents citizens. Representatives and People have the same attributes. A representative can be connected with one or more people, who might or might not be another representative. For example, this can show an MP and 2 of his business associates.

#### Party

A political party

#### Coalition

A coalition of political parties

#### Region

A geographical region

#### Constituency

A political constituency

#### District

A contested district

#### UUID

A UUID is a unique identifier, which is compatible with RFC4122. All entities in Zelus are uniquely identified by their UUID. To reference an entity within Zelus, you need to know its UUID.

#### API key

Every POST request must be made with an API key. You can also attach a GET request with an API key although it is not necessary. Each request (GET or POST) is logged and you will be able to keep track on your own API calls (future feature).

    POST /person?api_key=<api-key>

If you want to create records, please submit a request to create a user account in Zelus.

## Format

All records are in [JSON](http://www.json.org/) only. The general syntax for the response is:

    { 
      status: success || error,
      payload: ... 
    }

The `status` can be either `success` or `failure`. The `payload` is usually another JSON object or a list of JSON objects.

## API documentation

    GET /people
  
Show all people



    GET /people/:page_size/:page

Get all people, with pagination. Parameters are:

* page_size - how many records to get in a single call
* page - the page number

You will get a list of people records and the current page number asked for. For example, if you request `GET /people/10/1` you will get a list of the first 10 people records. If you request `GET /people/10/2` you will get a list of the next 10 people records.

The response for this request is:

    {
      status: success || error,
      page_size: <the size of the current page>
      next_page: <the next page number>
      previous_page: <the preious page number>
      payload: ...
    }

`previous_page` is the number of the prevous page, while `next_page` is the number of the next page.

    GET /representatives
  
Show all people who are members of parliament



    GET /person/:uuid
  
Show person by uuid. This includes the parties he/she has joined and/or is currently in. This also gives a list of people he/she is connected with.



    GET /representative/:uuid
  
Show an MP by uuid



    POST /person
  
Create a new person record. Parameters for creating a person are:

* name - full name
* email - primary email address
* facebook - Facebook profile link
* twitter - Twitter handle e.g. @user_name
* linkedin - Linkedin public profile link
* www - website
* phone - mobile phone number
* fax - fax number
* race - race e.g. Malay, Chinese, Indian etc
* sex - Male or Female
* birth_year - year of birth e.g. 1968
* education - a text field representing the highest education attained
* home_address - person's home address
* office_address - person's office address
* deceased_at - a date field representing the date of the person's death (if so)
* biography - a text field of information on the person

Note that you need to provide an API key along with every POST request.



    POST /representative
  
Create a new MP record. Parameters are as with creating a person record above.



    POST /person/:uuid
  
Update a person record, identified by its uuid. Parameters used are as with creating a person record as above. Note that you need to provide an API key along with every POST request.



    POST /representative/:uuid
    
Update a person record, identified by its uuid. Parameters used are as with creating a person record as above. Note that you need to provide an API key along with every POST request.



    GET /people/search/:query
    
Search for people by name or email



    GET /people/party/:uuid
    
Show all people by party, given the party uuid



    POST /person/party
    
Associate a person with a party. Parameters are:

* person_uuid
* party_uuid

Note that you need to provide an API key along with every POST request.



    POST /person/connect
    
Connect a person with another person. Parameters are:

* uuid1 - uuid of the first person
* uuid2 - uuid of the second person
* relation - the relationship between the 2 people e.g. father-son, husband-wife, friend, business associate, brother-sister etc

Note that you need to provide an API key along with every POST request.



    GET /regions
    
Show all regions



    GET /coalitions
    
Show all coalitions



    GET /parties

Show all parties



    GET /constituencies

Show all constituencies



    GET /districts

Show all districts
