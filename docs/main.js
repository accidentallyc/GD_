const {createApp, ref} = Vue

function main() {
    const app = createApp({
        setup() {
            const directoryItems = ref(window.data);
            const needle = ref('')

            return {
                data: window.data,
                needle,
                directoryItems,
                onSearchDirectory : _.debounce(() => {
                    var result = _.filter(window.data, (v) => _.includes(v.name, needle.value))
                    directoryItems.value = result
                },150)
            }
        },
        components: {
            ContentComponent
        },
        template: `
        <div class="panel-container bg-panel" id="directory">
            <div class="panel">
                <input type="text" @keyup="onSearchDirectory()" v-model="needle" class="bg-dark" placeholder="Search method name..."/>
                <ul>
                    <li v-for="(d) in directoryItems" :key="d.name" :class="{ 'is_pending': d.is_pending }">
                        <a :href="'#' + d.name">
                        {{ d.name }}
                        </a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="panel-container" id="contents">
            <div class="bg-panel panel pad-1">
                <div v-for="(d) in data" :key="d.name" :id="d.name">
                    <h1>{{ d.name }}</h1>
                    
                    <ContentComponent v-if="!d.is_pending" :d="d" />
                    <div v-if="d.is_pending" class="bg-dark pad-1">
                        Not Yet Implemented    
                    </div>
                </div>
            </div>
        </div>
        `
    }).mount('#app')
}

const ContentComponent = {
    props: ['d'],
    template: `
        <div v-if="d.descp">{{d.descp.join("")}}</div>
        
        <template v-if="d.arguments">
            <h2>Arguments</h2>
            <template v-for="arg in d.arguments">
                <i class="left-2">{{arg[0]}}</i>
                : {{arg[1]}}
                <br/>
            </template>
            
        </template>
        
        <template v-if="d.returns">
            <h2>Returns</h2>
            <i class="left-2">{{d.returns[0]}}</i>
            : {{d.returns[1]}}
        </template>
                    
        <template v-if="d.example">
            <h2>Example</h2>
            <div class="bg-dark pad-1">
                <code>
                    <template v-for="(d) in d.example">{{d}}<br/></template>
                </code>
            </div>
        </template>
    `,
}

main()
