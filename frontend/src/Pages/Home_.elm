module Pages.Home_ exposing (Model, Msg, page)

import API.API exposing (GetCategoriesResponse, getCategories)
import Css exposing (auto, backgroundColor, bold, border2, border3, borderBox, borderRadius, boxSizing, color, fontFamilies, fontSize, fontWeight, height, hex, margin2, marginTop, num, opacity, padding2, pct, px, rem, solid, width)
import Effect exposing (Effect)
import Gen.Params.Home_ exposing (Params)
import Html.Styled exposing (button, div, input, option, select, text, toUnstyled)
import Html.Styled.Attributes exposing (css, disabled, type_, value)
import Html.Styled.Events exposing (onClick, onInput)
import Http
import Page
import Ports.Port exposing (liffIDTokenReceiver, liffInit)
import Request
import Shared
import View exposing (View)


page : Shared.Model -> Request.With Params -> Page.With Model Msg
page shared req =
    Page.advanced
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- INIT


type alias Model =
    { category : String, price : String, idToken : String }


init : ( Model, Effect Msg )
init =
    ( { category = "", price = "", idToken = "" }, Effect.fromCmd <| liffInit () )



-- UPDATE


type Msg
    = CategoryInput String
    | PriceInput String
    | ButtonClick
    | GetIdToken String
    | GetCategories (Result Http.Error GetCategoriesResponse)


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    let
        toEffect : ( Model, Cmd Msg ) -> ( Model, Effect Msg )
        toEffect ( m, e ) =
            ( m, Effect.fromCmd e )
    in
    toEffect <|
        case msg of
            CategoryInput category ->
                ( { model | category = category }, Cmd.none )

            PriceInput price ->
                ( { model | price = price }, Cmd.none )

            ButtonClick ->
                ( model, Cmd.none )

            GetIdToken idToken ->
                ( { model | idToken = idToken }, getCategories GetCategories idToken )

            GetCategories res ->
                ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    liffIDTokenReceiver GetIdToken



-- VIEW


view : Model -> View Msg
view model =
    { title = "登録"
    , body =
        [ toUnstyled <|
            div [ css [ width <| pct 80, margin2 (px 0) auto ] ]
                [ div
                    [ css
                        [ width <| pct 100
                        , marginTop <| px 20
                        , fontWeight bold
                        , fontFamilies [ "ヒラギノ角ゴ ProN W3", "HiraKakuProN-W3", "游ゴシック", "Yu Gothic", "メイリオ", "Meiryo", "Verdana", "Helvetica", "Arial", "sans-serif" ]
                        ]
                    ]
                    [ text "カテゴリー" ]
                , select
                    [ css
                        [ width <| pct 100
                        , marginTop <| rem 1
                        , height <| px 44
                        , borderRadius <| rem 0.5
                        , border3 (px 1) solid (hex "000000")
                        , backgroundColor <| hex "ffffff"
                        , color <| hex "000000"
                        , fontSize <| px 16
                        , boxSizing borderBox
                        ]
                    , onInput CategoryInput
                    , value model.category
                    ]
                    [ option [ value "" ] []
                    , option [ value "電気" ] [ text "電気" ]
                    , option [ value "水道" ] [ text "水道" ]
                    , option [ value "ガス" ] [ text "ガス" ]
                    , option [ value "携帯" ] [ text "携帯" ]
                    , option [ value "食費" ] [ text "食費" ]
                    , option [ value "日用品" ] [ text "日用品" ]
                    , option [ value "交通費" ] [ text "交通費" ]
                    , option [ value "医療費" ] [ text "医療費" ]
                    , option [ value "遊び" ] [ text "遊び" ]
                    , option [ value "衣類" ] [ text "衣類" ]
                    , option [ value "その他" ] [ text "その他" ]
                    ]
                , div
                    [ css
                        [ width <| pct 100
                        , marginTop <| rem 1
                        , fontWeight bold
                        , fontFamilies [ "ヒラギノ角ゴ ProN W3", "HiraKakuProN-W3", "游ゴシック", "Yu Gothic", "メイリオ", "Meiryo", "Verdana", "Helvetica", "Arial", "sans-serif" ]
                        ]
                    ]
                    [ text "金額" ]
                , input
                    [ css
                        [ width <| pct 100
                        , marginTop <| rem 1
                        , height <| px 40
                        , borderRadius <| rem 0.5
                        , border2 (px 1) solid
                        , padding2 (px 0) (px 8)
                        , fontSize <| px 16
                        , boxSizing borderBox
                        ]
                    , type_ "number"
                    , value model.price
                    , onInput PriceInput
                    ]
                    []
                , button
                    [ css
                        [ width <| pct 100
                        , marginTop <| rem 2
                        , height <| px 44
                        , borderRadius <| rem 0.5
                        , border2 (px 0) solid
                        , backgroundColor <| hex "00B900"
                        , color <| hex "ffffff"
                        , fontWeight bold
                        , fontSize <| px 15
                        , boxSizing borderBox
                        , opacity <|
                            num
                                (if disableBoolean model then
                                    0.5

                                 else
                                    1
                                )
                        ]
                    , disabled <| disableBoolean model
                    , onClick ButtonClick
                    ]
                    [ text "登録" ]
                , div [] [ text model.idToken ]
                ]
        ]
    }


disableBoolean : Model -> Bool
disableBoolean model =
    model.category == "" || model.price == ""
