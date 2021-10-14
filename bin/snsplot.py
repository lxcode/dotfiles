#! /usr/bin/env python3

# Takes as input a CSV produced by gF with date and value pinned.

# %% Setup
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib as mpl
import seaborn as sns

title = ""

cardinalred = ["#8C1515"]
stanford = ["#8C1515", "#175E54", "#279989", "#8F993E", "#6FA287", "#4298B5", "#007C92"]
stlight = ["#2D716F", "#59B3A9", "#A6B168", "#8AB8A7", "#67AFD2", "#009AB4"]
stdark = ["#014240", "#017E7C", "#7A863B", "#417865", "#016895", "#006B81"]
stbright = ["#E98300", "#E04F39", "#FEDD5C", "#620059", "#651C32", "#5D4B3C"]

palette = stanford + stdark

sns.set(font="Roboto")
sns.set(font_scale=0.8)
sns.set_palette(sns.color_palette(palette), n_colors=100)
sns.set_style("whitegrid")
plt.rcParams["axes.labelweight"] = "bold"
plt.rcParams["axes.titleweight"] = "bold"
plt.rcParams["axes.titlesize"] = 10
plt.rcParams["figure.autolayout"] = True

data_csv = "/tmp/in.csv"
df = pd.read_csv(data_csv)
df.columns = ["date", "tag", "count", "pct", "hist"]
df["date"] = pd.to_datetime(df["date"])
print(df.head())


# %% Calculate top values, remove rest from a tmp dataframe
top = 10
toptags = df.tag.value_counts()[:top]
threshold = toptags.values[top - 1:top][0]

tmpdf = df
tmpdf = tmpdf.set_index("date")
s = tmpdf.tag.value_counts().gt(threshold)
tmpdf = tmpdf.loc[tmpdf.tag.isin(s[s].index)]


# %% Horizontal bars
plt.figure(figsize=(10, 6))
plt.title(title)
ylabel = "Hashtag"

sns.countplot(
    y="tag", data=df, order=df.tag.value_counts().iloc[:top].index, color=cardinalred
).set_ylabel(ylabel)

plt.savefig("/tmp/snsbar.png", dpi=300)
plt.savefig("/tmp/snsbar.pdf")


# %% Scatter plot
plt.figure(figsize=(10, 6))
plt.xticks(rotation=15)
plt.title(title)

sns.scatterplot(
    x="date",
    y="count",
    hue="tag",
    hue_order=df.tag.value_counts().iloc[:top].index,
    data=tmpdf,
    s=15,
    linewidth=0,
).legend().set_title = None

plt.savefig("/tmp/snsplot.png", dpi=300)
plt.savefig("/tmp/snsplot.pdf")


# %% Line plot
# If dealing with minute resolution data, resample as desired
tmpdf = df
tmpdf = tmpdf.set_index("date")
ldf = tmpdf
ldf = tmpdf.groupby("tag").resample("D").mean()
ldf["count"] = ldf["count"].fillna(0)

plt.figure(figsize=(10, 6))
plt.xticks(rotation=15)
plt.title(title)

sns.lineplot(
    x="date",
    y="count",
    linewidth=2,
    hue_order=df.tag.value_counts().iloc[:top].index,
    hue="tag",
    data=ldf,
).legend().set_title = None

plt.savefig("/tmp/snsline.png", dpi=300)
plt.savefig("/tmp/snsline.pdf")


# %% Histplot
# Just general activity in the dataset
plt.figure(figsize=(10, 6))
plt.xticks(rotation=15)
plt.title(title)

sns.histplot(x="date", data=df, kde=True, bins=666)

plt.savefig("/tmp/snsdist.png", dpi=300)
plt.savefig("/tmp/snsdist.pdf")

# %% Stacked hist
plt.figure(figsize=(10, 6))
plt.xticks(rotation=15)
plt.title(title)

bins = pd.date_range(start='2013-12-07', end='2014-08-19', freq='1M')
sns.histplot(x="date", data=df, hue="tag", multiple="dodge", bins=mpl.dates.date2num(bins))

plt.savefig("/tmp/snsdist.png", dpi=300)
plt.savefig("/tmp/snsdist.pdf")
