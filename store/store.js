const actionTypes = {
  FETCH_QUOTE: "FETCH_QUOTE",
  FETCH_NEWS: "FETCH_NEWS",
  FETCH_EPISODES: "FETCH_EPISODES",
};

export const actions = {
  fetchQuote: (quote) => ({ type: actionTypes.FETCH_QUOTE, quote }),
  fetchNews: (news) => ({ type: actionTypes.FETCH_NEWS, news }),
  fetchEpisodes: (episodes) => ({ type: actionTypes.FETCH_EPISODES, episodes }),
};

const initialState = {
  quote: "",
  news: [],
  episodes: [],
};

export const reducer = (state = initialState, action) => {
  switch (action.type) {
    case actionTypes.FETCH_NEWS:
      return { ...state, news: action.news };
    case actionTypes.FETCH_QUOTE:
      return { ...state, quote: action.quote };
    case actionTypes.FETCH_EPISODES:
      return { ...state, episodes: action.episodes };
    default:
      return state;
  }
};
