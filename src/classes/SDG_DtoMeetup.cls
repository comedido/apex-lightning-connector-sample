/**********************************************************************************
* @author       JVN - josep@clappsolutions.com - www.clappsolutions.com
* @date         19 June 2015
* @description  A set of DTOs that represents Meetup structure.
*               Best practice:
*                   - Use Inner Classes for DTO's.
*                   - Avoid having a lot of Apex Classes.
*                   - Avoid dispersion. All DTO are under [namespace]_Dto[context].
*                   - Easy to find and mantain.
* @Revision     
**********************************************************************************/
public class SDG_DtoMeetup {
    
    //-- CONSTRUCTOR
    /**
     * Enforce non-instantiabily.
     */
    public SDG_DtoMeetup() {
        //throw new SDG_Exception.DtoMeetupException('SDG_DtoMeetup must never be instantiated.');
    }

    //-- DESERIALIZE (PARSE) METHODS
    /**
     * Parses JSON string into GroupResult.
     *
     * @param {@code String} json
     * @return {@code GroupResult}
     */
    public static GroupResult parseGroupResult(String json) {
        return (GroupResult) System.JSON.deserialize(json, GroupResult.class);
    }

    /**
     * Parses JSON string into Org.
     *
     * @param {@code String} json
     * @return {@code Org}
     */
    public static EventResult parseEventResult(String json) {
        json = String.isEmpty(json) ? '' : json.replace('"time":', '"timex":').replace('"group":', '"groupx":');

        EventResult result = (EventResult) System.JSON.deserialize(json, EventResult.class);
        for (Eventx eventx : result.results) {
            eventx.created = DateTime.newInstance(Long.valueOf(eventx.created)).format('dd/MM/yyyy');
            eventx.timex = DateTime.newInstance(Long.valueOf(eventx.timex)).format('dd/MM/yyyy');
        }

        return result;
    }

    //-- INNER CLASSES
    /**
     * Class that represents the result of a Group request.
     */
    public class GroupResult {
        public List<Groupx> results;
        public Meta meta;
    }

    /**
     * Class that represents the result of an Event request.
     */
    public class EventResult {
        public List<Eventx> results;
        public Meta meta;
    }

    /**
     * Class that represents a Meetup Event.
     */
    public class Eventx {
        public Integer utc_offset;
        public Venue venue;
        public Integer headcount;
        public String visibility;
        public Integer waitlist_count;
        public String created;
        public Integer maybe_rsvp_count;
        public String description;
        public String how_to_find_us;
        public String event_url;
        public Integer yes_rsvp_count;
        public Integer duration;
        public Boolean announced;
        public String name;
        public String id {get; set;}
        public String timex;
        public Long updated;
        public Groupx groupx;
        public String status;
    }

    /**
     * Class that represents a Meetup Group.
     */
    public class Groupx {
        public Integer utc_offset;
        public String country;
        public String visibility;
        public String city;
        public String timezone;
        public Long created;
        public List<Topic> topics;
        public String link;
        public Integer rating;
        public String description;
        public Double lon;
        public Group_photo group_photo;
        public String join_mode;
        public Organizer organizer;
        public Integer members;
        public String name;
        public Integer id;
        public String urlname;
        public Category category;
        public Double lat;
        public String who;
    }

    /**
     * Class that represents a Meetup Category.
     */
    public class Category {
        public String name;
        public Integer id;
        public String shortname;
    }

    /**
     * Class that represents a Meetup Organizer.
     */
    public class Organizer {
        public Integer member_id;
        public String name;
    }

    /**
     * Class that represents a Meetup Photo Group.
     */
    public class Group_photo {
        public String highres_link;
        public Integer photo_id;
        public String photo_link;
        public String thumb_link;
    }

    /**
     * Class that represents a Meetup Topic.
     */
    public class Topic {
        public String urlkey;
        public String name;
        public Integer id;
    }

    /**
     * Class that represents a Meetup Venue.
     */
    public class Venue {
        public String country;
        public String city;
        public String address_1;
        public String name;
        public Double lon;
        public Integer id;
        public Double lat;
        public Boolean repinned;
    }

    /**
     * Class that represents a Meetup Meta info.
     */
    public class Meta {
        public String next;
        public String method;
        public Integer total_count;
        public String link;
        public Integer count;
        public String description;
        public String lon;
        public String title;
        public String url;
        public String id;
        public Long updated;
        public String lat;
    }
}