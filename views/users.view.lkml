include: location.view
view: users {
  extends: [location]
  sql_table_name: public.users ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: age_tier {
    type: tier
    tiers: [0,10,20,30,40,50,60,70,80,90,100]
    # style: classic #Valor por default,
    sql: ${age} ;;

  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: city_link {
    type: string
    sql: ${TABLE}.city ;;
    link: {
      label: "Search the web"
      url: "http://www.google.com/search?q={{ value | url_encode }}"
      icon_url: "http://www.google.com/s2/favicons?domain=www.{{ value | url_encode }}.com"
    }
  }

  dimension: order_history_button {
    label: "Order History"
    sql: ${TABLE}.id ;;
    html: <a href="/explore/ecommerce_edher/order_items?fields=order_items.id, users.first_name, users.last_name, users.id, order_items.count, order_items.total_revenue&f[users.id]={{ value }}"><button>Order History</button></a> ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: full_name {
    type: string
    sql: CONCAT (${first_name}, ${last_name});;
  }

  dimension: length_name {
    type: string
    sql: length(${full_name});;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: state_link {
    type: string
    sql: ${TABLE}.state ;;
    map_layer_name: us_states
    html: {% if _explore._name == "order_items" %}
          <a href="/explore/training_ecommerce/order_items?fields=order_items.detail*&f[users.state]= {{ value }}">{{ value }}</a>
        {% else %}
          <a href="/explore/training_ecommerce/users?fields=users.detail*&f[users.state]={{ value }}">{{ value }}</a>
        {% endif %} ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: count {
    type: count
    drill_fields: [id, first_name, last_name, orders.count]
  }

  measure: average_age {
    type: average
    sql: ${age} ;;

  }
}
