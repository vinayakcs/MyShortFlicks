
#user creation
u=User.new
u.first_name="Mandrake"
u.last_name="Joy"
u.gender="male"
u.email="mandrak@joy.com"
u.profile_image_url="https://lh3.googleusercontent.com/-jg1r2CFcub4/AAAAAAAAAAI/AAAAAAAAAAA/1P4fgZou6II/photo.jpg"
u.bio="In 1952, an African-American musical group calling themselves the Debonaires had formed in Los Angeles, with members Arthur Lee Maye, Pete Fox, Obediah Jessie, Joe Winslow, and A.V. Odom. Winslow dropped out, leaving the qroup a quartet. Bass man Odom was out soon after, and was replaced by Richard Berry. Maye began putting baseball ahead of singing (he would later be a professional baseball player for the Milwaukee Braves), and the group brought in Beverly Thompson to replace him. Cornell Gunter, who had recently left the earliest lineup of the Platters, came in to make the group a quintet. The Debonaires made a handful of recordings for R"
u.save

u=User.new
u.first_name="Wayne"
u.last_name="Bruce"
u.gender="make"
u.email="wayne@bruce.com"
u.profile_image_url="http://upload.wikimedia.org/wikipedia/en/4/4f/BrotherPoster.jpg"
u.bio="He was a perfectionist in his work and would sometimes spend up to a year on a book. It was not uncommon for him to throw out 95% of his material until he settled on a theme for his book. For a writer he was unusual in that he preferred to be paid only after he finished his work rather than in advance.R"
u.save



u=User.new
u.first_name="boom"
u.last_name="boom"
u.gender="other"
u.email="boom@boom.com"
u.profile_image_url="http://i.ytimg.com/vi/deH_tFTqVtU/maxresdefault.jpg"
u.bio="The etymology of foo is explored in the Internet Engineering Task Force (IETF) RFC 3092, which gives the earliest documented use as being in the 1930s comic Smokey Stover by Bill Holman, where it is used as a nonsense word.[10][11] Holman states that he used the word due to having seen it on bottom of a jade C"
u.save

u=User.new
u.first_name="bat"
u.last_name="man"
u.gender="male"
u.email="bat@man.com"
u.profile_image_url="http://i.kinja-img.com/gawker-media/image/upload/s--i-6AwJp0--/c_fit,fl_progressive,q_80,w_636/1243884992631060838.png"
u.bio="One day I called Bill and said, 'I have a new character called the Bat-Man and I've made some crude, elementary sketches I'd like you to look at'. He came over and I showed him the drawings. At the time, I only had a small domino mask, like the one Robin later wore, on Batman's face. Bill said, 'Why not make him look more like a bat and put a hood on him, and take the eyeballs out and just put slits for eyes to make him look more mysterious?' At this point, the Bat-Man wore a red union suit; the wings, trunks, and mask were black. I thought that red and black would be a good combination. Bill said that the costume was too bright: 'Color it dark gray to make it look more ominous'. The cape looked like two stiff bat wings attached to his arms. As Bill and I talked, we realized that these wings would get cumbersome when Bat-Man was in action, and changed them into a cape, scalloped to look like bat wings when he was fighting or swinging down on a rope. Also, he didn't have any gloves on, and we added them so that he wouldn't leave fingerprints."
u.save


#video creation
v=Video.new
v.user_id=1
v.video_url="https://www.youtube.com/watch?v=j_5KgpN38hM"
#v.video_thumbnail_url="http://img.youtube.com/vi/oh8nZR1VoLQ/0.jpg"
v.save

v=Video.new
v.user_id=2
v.video_url="https://www.youtube.com/watch?v=ScMOyURq9os"
#v.video_thumbnail_url="http://img.youtube.com/vi/ScMOyURq9os/0.jpg"
v.save

v=Video.new
v.user_id=1
v.video_url="https://www.youtube.com/watch?v=NTlDDE8DRAg"
#v.video_thumbnail_url="http://img.youtube.com/vi/NTlDDE8DRAg/0.jpg"
v.featured_at=Time.zone.now
v.save

v=Video.new
v.user_id=4
v.video_url="https://www.youtube.com/watch?v=muCtJsy-d9w"
#v.video_thumbnail_url="http://img.youtube.com/vi/muCtJsy-d9w/0.jpg"
#v.title="batman"
#v.description="bad ass batman is yet it again , yaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa!!!"
v.featured_at=Time.zone.now
v.save

v=Video.new
v.user_id=4
v.video_url="https://www.youtube.com/watch?v=r9fSkcAYyZ8"
#v.video_thumbnail_url="http://img.youtube.com/vi/r9fSkcAYyZ8/0.jpg"
#v.title="batman kills"
#v.description="batman hey hey ya ya yo man, boom boom !!!"
v.featured_at=Time.zone.now
v.save




u1=User.find(1)
u2=User.find(2)
u3=User.find(3)
v1=Video.find(1)
v2=Video.find(2)
v3=Video.find(3)
i1=Icon.find(1)
i2=Icon.find(2)
i3=Icon.find(3)
i4=Icon.find(4)

#badges
u1.add_badge_to_video(v1,i1)
u1.add_badge_to_video(v1,i2)
u2.add_badge_to_video(v1,i1)
u3.add_badge_to_video(v1,i1)
u1.add_badge_to_video(v2,i1)
u2.add_badge_to_video(v2,i2)
u3.add_badge_to_video(v2,i3)

#messages


u1.send_message_to_user(u2,"hello my dear kruki, If roses were red and violets could be blue,I'd take us away to a place just for two.You'd see my true colors and all that I felt.I'd see that you could love me and nobody else.")

u2.send_message_to_user(u1,"hello my dear barbadok, A lover asked his beloved,Do you love yourself morethan you love me?The beloved replied,I have died to myselfand I live for you.")

#channels
c=Channel.new
c.user=u1
c.title="channel mama"
c.description="some shit description , so time passes"
c.image_url="http://upload.wikimedia.org/wikipedia/en/d/dd/The_Persistence_of_Memory.jpg"
c.save

c=Channel.new
c.user=u2
c.title="channel japan"
c.description="calling all samurais and ninjas"
c.image_url="http://i2.wp.com/www.giapponizzati.com/wp-content/uploads/2012/11/Samurai_vs_Ninja_by_Sleepless_Shadowman.jpg"
c.save

c=Channel.new
c.user=u3
c.title="war stuffs"
c.description="herr komandant"
c.image_url="http://i.dailymail.co.uk/i/pix/2011/03/30/article-1371512-005D3DAF00000258-315_468x286.jpg"
c.save



c1=Channel.find(1)
c2=Channel.find(2)
c3=Channel.find(3)

#channelgraphs 

u1.add_video_to_channel(v1,c1)
u2.add_video_to_channel(v2,c2)
u2.add_video_to_channel(v1,c2)
u3.add_video_to_channel(v1,c3)
u3.add_video_to_channel(v2,c3)
u3.add_video_to_channel(v3,c3)

#comments
com1=v1.comments.new
com1.content="comment yea"
com1.user=u1
com1.save
u1.update_field_count("comments_count",true,1)
v1.update_field_count("comments_count",true,1)

com2=v1.comments.new
com2.content="comment shit"
com2.user=u2
com2.save
u2.update_field_count("comments_count",true,1)
v1.update_field_count("comments_count",true,1)

com3=v2.comments.new
com3.content="comment poop"
com3.user=u2
com3.save
#u2.update_field_count("comments_count",true,1)
#v2.update_field_count("comments_count",true,1)

#subscriptions
s1=Subscription.new
s1.channel=c1
s1.user=u1
s1.save

s2=Subscription.new
s2.channel=c2
s2.user=u2
s2.save

s3=Subscription.new
s3.channel=c2
s3.user=u1
s3.save

#casts
ca1=Cast.new
ca1.video=v1
ca1.assignee=u2
ca1.assignor=u1
ca1.cast_type="actor"
ca1.save

ca2=Cast.new
ca2.video=v2
ca2.assignee=u1
ca2.assignor=u2
ca2.cast_type="actress"
ca2.save

#votes

v1=ca1.votes.new
v1.user=u1
v1.save

v2=ca1.votes.new
v2.user=u2
v2.save

v3=ca2.votes.new
v3.user=u1
v3.save

v4=ca2.votes.new
v4.user=u2
v4.save

