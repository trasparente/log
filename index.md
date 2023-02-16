---
date: 1
class: compact
---

Home
====

- remove dates in metadata and archive if collection isnt posts and date is `site.time`
- Write page in assets
- link to add data item
- better bars
- implement multiple filters in archive

DOW
---

{{site.data.dow.worlds.avalon|inspect}}

- "worlds" {slug: ...}
  - name
  - "gods" []
    - name
    - description
    - points
  - "state.json"
    - start
    - end
    - age
    - playing
  - "lands" [] (mountains, hills, lakes, streams, rivers, forests, jungles, deserts, grasslands, tundra, steppes)
    - type
    - position
    - dimensions
  - "climate" [] (fog, rain, snow, sun, heat, cold, sleet)
    - type
    - position
    - dimensions
  - "races" []
    - name
    - description
    - alignment
    - born position
    - "subraces" []
      - name
      - description
      - alignment [-1,+1]
      - born position
  - "cities" []
    - name
    - position
    - alignment
    - population []
      - [ sub ]race, people
    - "knowledge"
    - "armies" []
  - "avatars" []
    - god
    - name
    - description
    - position
  - "order" []
    - creator
    - name
    - description
    - [ sub ]race
- "powers" {}
  - name
  - points []
    - 3
    - 5
    - 8
- "ages" (rounds) []
  - 3
  - 4
  - 5